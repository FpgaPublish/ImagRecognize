`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/05 17:39:19
// Design Name: 
// Module Name: sccb_interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module sccb_interface #(
    //mode
    
    //number
    parameter NB_VER = 0 ,//normal
    parameter NB_SYS_CLK = 10, //10s
    //shake bus
    parameter WD_SHK_SYNC = 16,
    parameter WD_SHK_DLAY = 15,
    //width
    parameter WD_ERR_INFO = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_rst_n,  
    //sccb
    output          m_sccb_sio_clk, //sccb serial IO clk
    output          m_sccb_sio_out, //sccb serial IO out
    output          m_sccb_sio_tri, //sccb serial IO tri
    input           m_sccb_sio_in , //sccb serial IO in
    //shake slaver
    input                       s_shk_sccb_wvalid,  //
    input    [WD_SHK_SYNC-1:0]  s_shk_sccb_saddr ,
    input    [WD_SHK_SYNC-1:0]  s_shk_sccb_smosi ,
    input    [WD_SHK_DLAY-1:0]  s_shk_sccb_dmosi ,
    output                      s_shk_sccb_wready,
    output   [WD_SHK_SYNC-1:0]  s_shk_sccb_smiso ,
    output   [WD_SHK_DLAY-1:0]  s_shk_sccb_dmiso ,
    //error bus
    input    [WD_ERR_INFO-1:0]  s_err_sccb_info1,
    output   [WD_ERR_INFO-1:0]  m_err_sccb_info1
);

//========================================================
//function to math and logic

//========================================================
//localparam to converation and calculate
localparam NB_CLK_PER  = 2500 / NB_SYS_CLK; //ns,clock period
localparam NB_CLK_LOW  = 1250 / NB_SYS_CLK; //ns,clock low
localparam NB_LOW_HALF =  625 / NB_SYS_CLK; //ns,clock low half to change data
localparam NB_HGH_HALF = 1725 / NB_SYS_CLK; //ns,clock high to read data
localparam NB_PHASE_CLK = 9;

//========================================================
//register and wire to time sequence and combine
//sccb
reg r_sccb_sio_clk;
reg r_sccb_sio_out;
reg r_sccb_sio_tri;

reg [19:0] r_timing_cnt;
reg [19:0] r_clock_cnt;

reg                   r_shk_sccb_wready;
reg [WD_SHK_SYNC-1:0] r_shk_sccb_smiso ;
//========================================================
//always and assign to drive l ogic and connect
//>>>>state machine<<<<//
//state name
localparam IDLE   =  0;
localparam START  =  1;
localparam PHASE1 =  2;
localparam PHASE2 =  3;
localparam PHASE3 =  4;
localparam OVER   =  5;
//state variable
reg [3:0] cstate = IDLE;

wire w_phase_jump_flg = r_timing_cnt == NB_CLK_PER - 1'b1 
                    &&  r_clock_cnt  == NB_PHASE_CLK - 1'b1;
//state logic
always @(posedge i_sys_clk)
    if(!i_sys_rst_n)
    begin
       cstate <= IDLE;
    end
    else
    begin
        case(cstate)
            IDLE : if(1) //wheter goto next state
                begin  
                    if(1) //which state to go
                    begin
                        cstate <= START;
                    end
                end
            START: if(s_shk_sccb_wvalid)
                begin   
                    if(1)
                    begin
                        cstate <= PHASE1;
                    end
                end
            PHASE1: if(w_phase_jump_flg)
                begin
                    if(1)
                    begin
                        cstate <= PHASE2;
                    end
                end
            PHASE2: if(w_phase_jump_flg)
                begin
                    if(s_shk_sccb_saddr[0])
                    begin
                        cstate <= PHASE3;
                    end
                    else 
                    begin
                        cstate <= OVER;
                    end
                end
            PHASE3: if(w_phase_jump_flg)
                begin
                    if(1)
                    begin
                        cstate <= OVER;
                    end
                end
            OVER: 
                begin
                    if(1)
                    begin
                        cstate <= IDLE;
                    end
                end
            default: cstate <= IDLE;
        endcase
    end
    
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_timing_cnt <= 1'b0;
    end
    else if(cstate == PHASE1
        ||  cstate == PHASE2
        ||  cstate == PHASE3)
    begin
        if(r_timing_cnt == NB_CLK_PER - 1'b1)
        begin
            r_timing_cnt <= 1'b0;
        end
        else 
        begin
            r_timing_cnt <= r_timing_cnt + 1'b1;
        end
    end
end
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_clock_cnt <= 1'b0;
    end
    else if(cstate == PHASE1
        ||  cstate == PHASE2
        ||  cstate == PHASE3)
    begin
        if(r_timing_cnt == NB_CLK_PER - 1'b1)
        begin
            if(r_clock_cnt == NB_PHASE_CLK - 1'b1)
            begin
                r_clock_cnt <= 1'b0;
            end
            else 
            begin
                r_clock_cnt <= r_clock_cnt + 1'b1;
            end
        end
    end
end
//<<<<end state>>>>//
// ----------------------------------------------------------
// sccb driver
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_sccb_sio_clk <= 1'b1;
    end
    else if(cstate == PHASE1
        ||  cstate == PHASE2
        ||  cstate == PHASE3)
    begin
        if(r_timing_cnt == 0)
        begin
            r_sccb_sio_clk <= 1'b0;
        end
        else if(r_timing_cnt == NB_CLK_LOW)
        begin
            r_sccb_sio_clk <= 1'b1;
        end
    end
end
assign m_sccb_sio_clk = r_sccb_sio_clk;
//data out
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_sccb_sio_out <= 1'b01;
        r_sccb_sio_tri <= 1'b1;
    end
    else if(cstate == PHASE1 && r_timing_cnt == NB_LOW_HALF - 1'b1)
    begin
        if(r_clock_cnt < NB_PHASE_CLK - 1)
        begin
            r_sccb_sio_out <= s_shk_sccb_saddr[NB_PHASE_CLK - 2 - r_clock_cnt];
            r_sccb_sio_tri <= 1'b1;
        end
        else 
        begin
            r_sccb_sio_out <= 1'b1;
            r_sccb_sio_tri <= 1'b0;
        end
    end
    else if(cstate == PHASE2 && s_shk_sccb_saddr[0] && r_timing_cnt == NB_LOW_HALF - 1'b1)
    begin
        if(r_clock_cnt < NB_PHASE_CLK - 1)
                begin
                    r_sccb_sio_out <= s_shk_sccb_smosi[NB_PHASE_CLK - 2 - r_clock_cnt];
                    r_sccb_sio_tri <= 1'b1;
                end
                else 
                begin
                    r_sccb_sio_out <= 1'b1;
                    r_sccb_sio_tri <= 1'b0;
                end
    end
    else if(cstate == PHASE2 && !s_shk_sccb_saddr[0] && r_timing_cnt == NB_LOW_HALF - 1'b1)
    begin
        r_sccb_sio_out <= 1'b0;
        r_sccb_sio_tri <= 1'b0;
    end
    else if(cstate == PHASE3 && r_timing_cnt == NB_LOW_HALF - 1'b1)
    begin
        if(r_clock_cnt < NB_PHASE_CLK - 1)
                begin
                    r_sccb_sio_out <= s_shk_sccb_dmosi[NB_PHASE_CLK - 2 - r_clock_cnt];
                    r_sccb_sio_tri <= 1'b1;
                end
                else 
                begin
                    r_sccb_sio_out <= 1'b1;
                    r_sccb_sio_tri <= 1'b0;
                end
    end
end
assign m_sccb_sio_out = r_sccb_sio_out;
assign m_sccb_sio_tri = r_sccb_sio_tri;
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_shk_sccb_smiso <= 1'b0;
    end
    else if(cstate == PHASE2 && !s_shk_sccb_saddr[0])
    begin
        if(r_timing_cnt == NB_HGH_HALF - 1'b1)
        begin
            r_shk_sccb_smiso <= {r_shk_sccb_smiso[WD_SHK_SYNC-2:0],m_sccb_sio_in};
        end
    end
end
assign s_shk_sccb_smiso = r_shk_sccb_smiso;
// ----------------------------------------------------------
// shake ready 
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_shk_sccb_wready <= 1'b0;
    end
    else if(cstate == OVER)
    begin
        r_shk_sccb_wready <= 1'b1;
    end
end
assign s_shk_sccb_wready = r_shk_sccb_wready;
//========================================================
//module and task to build part of system

//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor
ila_1x5_8x1 u_ila_1x5_8x1 (
	.clk(i_sys_clk), // input wire clk

	.probe0(m_sccb_sio_clk), // input wire [0:0]  probe0  
	.probe1(m_sccb_sio_out), // input wire [0:0]  probe1 
	.probe2(m_sccb_sio_tri), // input wire [0:0]  probe2 
	.probe3(m_sccb_sio_in ), // input wire [0:0]  probe3 
	.probe4(r_shk_sccb_wready), // input wire [0:0]  probe4 
	.probe5(r_shk_sccb_smiso )  // input wire [7:0]  probe5
);



endmodule
