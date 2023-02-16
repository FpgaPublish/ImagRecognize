`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/12 16:47:15
// Design Name: 
// Module Name: sccb_prtc
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
module sccb_prtc #(
    //mode
    
    //number
    parameter NB_VER = 0 ,//normal
    parameter NB_SYS_CYC = 10, //ns
    //width
    parameter WD_SHK_DAT  = 8,
    parameter WD_SHK_ADR  = 8,
    
    parameter WD_ERR_INFO = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_rst_n,  
    //sccb ports
    output          m_port_sccb_scl    ,
    output          m_port_sccb_sda_out,
    output          m_port_sccb_sda_tri, //1: write 0:read
    input           m_port_sccb_sda_inp,
    //shake control
    input                    s_shk_sccb_valid,
    output                   s_shk_sccb_ready,
    input  [WD_SHK_ADR-1:0]  s_shk_phse_maddr,
    input  [WD_SHK_DAT-1:0]  s_shk_phse_mdata,
    input  [1         -1:0]  s_shk_phse_msync, //0: read 1: write
    output [WD_SHK_DAT-1:0]  s_shk_phse_sdata,
    //error bus
    output   [WD_ERR_INFO-1:0]  m_err_sccb_info1
);
//========================================================
//function to math and logic
//funtion y = 2 ^ N
function automatic integer EXP2_N(input integer N1);
    for(EXP2_N = 1; N1 > 0; EXP2_N = EXP2_N * 2)
    begin:FOR_EXP2
        N1 = N1 - 1;
    end
endfunction
//funtion y = [log2(N)]
function automatic integer LOG2_N(input integer N2);
    for(LOG2_N = 0; N2 > 1; LOG2_N = LOG2_N + 1)
    begin:FOR_LOG2
        N2 = N2 >> 1;
    end
endfunction
//========================================================
//localparam to converation and calculate
//SCCB timing
localparam NB_CYC_SCL = 2500 / NB_SYS_CYC; //ns, scl clock cycle
localparam NB_SCL_LOW = 1500 / NB_SYS_CYC; //ns, scl low
localparam NB_LOW_HAF =  750 / NB_SYS_CYC; //ns, half of scl low 
localparam NB_HGH_HAF = 2000 / NB_SYS_CYC; //ns, half of scl high

localparam NB_PHASE_BIT = 9;
//width calculate
localparam WD_CYC_SCL   = LOG2_N(NB_CYC_SCL) + 1; //bit, add1 ensure data is in range
localparam WD_PHASE_BIT = LOG2_N(NB_PHASE_BIT) + 1'b1;//bit,add1 ensure data is in range
//write read span
localparam NB_WRRD_SPAN = 4; //cycle scl, write and read span
//========================================================
//register and wire to time sequence and combine
//timing counter
reg [WD_CYC_SCL  -1:0] r_cyc_scl_cnt;
reg [WD_PHASE_BIT-1:0] r_phase_bit_cnt;
reg [4           -1:0] r_phase_byte_cnt;
//signal temp
reg [WD_SHK_ADR-1:0]  r_shk_phse_maddr = 1'b0;
reg [WD_SHK_DAT-1:0]  r_shk_phse_mdata = 1'b0;
reg [1         -1:0]  r_shk_phse_msync = 1'b0;
//addr 
reg r_write_raddr_flg; //read first step write addr ok flag
//sccb driver
reg r_port_sccb_scl    ;
reg r_port_sccb_sda_out;
reg r_port_sccb_sda_tri;
//sccb data read
reg                  r_shk_sccb_ready;
reg [WD_SHK_DAT-1:0] r_shk_phse_sdata;
//========================================================
//always and assign to drive logic and connect
/* @begin state machine */
//state name
localparam IDLE     = 0; 
localparam START    = 1;
localparam PHASE    = 2; 
localparam FINISH   = 3;
localparam CONTINUE = 4; //read need twice
localparam OVER     = 5;
//state variable
reg [3:0] cstate = IDLE;

//state logic
always @(posedge i_sys_clk)
    if(!i_sys_rst_n)
    begin
       cstate <= IDLE;
    end
    else
    begin
        case(cstate)
            IDLE : if(s_shk_sccb_valid) //wheter goto next state
                begin  
                    if(1) //which state to go
                    begin
                        cstate <= START;
                    end
                end
            START: if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1)
                begin
                    if(1)
                    begin
                        cstate <= PHASE;
                    end
                end
            PHASE: if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1 && r_phase_bit_cnt == NB_PHASE_BIT - 1'b1)
                begin
                    if(r_shk_phse_msync && r_phase_byte_cnt == 3-1) //write
                    begin
                        cstate <= FINISH;
                    end
                    else if(!r_shk_phse_msync && r_phase_byte_cnt == 2-1) //read
                    begin
                        cstate <= FINISH;
                    end
                end
            FINISH: if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1)
                begin
                    if(!r_shk_phse_msync && !r_write_raddr_flg) //addr not write 
                    begin
                        cstate <= CONTINUE;
                    end
                    else
                    begin
                        cstate <= OVER;
                    end
                end
            CONTINUE: if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1) 
                begin
                    if(r_phase_bit_cnt == NB_WRRD_SPAN - 1'b1) //span of write andc read
                    begin
                        cstate <= START;
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
/* @end state machine  */
// ----------------------------------------------------------
// counter for timing

always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_cyc_scl_cnt <= 1'b0;
    end
    else if(cstate == START || cstate == PHASE || cstate == FINISH || cstate == CONTINUE) //bast timing clock
    begin
        if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1) //real time count full
        begin
            r_cyc_scl_cnt <= 1'b0;
        end
        else
        begin
            r_cyc_scl_cnt <= r_cyc_scl_cnt + 1'b1;
        end
    end
end
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE || cstate == START) //state IDLE reset
    begin
        r_phase_bit_cnt <= 1'b0;
    end
    else if(cstate == PHASE)
    begin
        if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1)
        begin
            if(r_phase_bit_cnt == NB_PHASE_BIT - 1'b1) //bit count full
            begin
                r_phase_bit_cnt <= 1'b0;
            end
            else
            begin
                r_phase_bit_cnt <= r_phase_bit_cnt + 1'b1;
            end
        end
    end
    else if(cstate == CONTINUE)
    begin
        r_phase_bit_cnt <= r_phase_bit_cnt + 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE || cstate == START) //state IDLE reset
    begin
        r_phase_byte_cnt <= 1'b0;
    end
    else if(cstate == PHASE)
    begin
        if(r_cyc_scl_cnt == NB_CYC_SCL - 1'b1 && r_phase_bit_cnt == NB_PHASE_BIT - 1'b1) //last bit is ok
        begin
            r_phase_byte_cnt <= r_phase_byte_cnt + 1'b1;
        end
    end
end
//shake signlas
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE && s_shk_sccb_valid) //state IDLE reset
    begin
        r_shk_phse_maddr <= s_shk_phse_maddr;
        r_shk_phse_mdata <= s_shk_phse_mdata;
        r_shk_phse_msync <= s_shk_phse_msync;
    end
end
//read write addr flag
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_write_raddr_flg <= 1'b0;
    end
    else if(cstate == CONTINUE)
    begin
        r_write_raddr_flg <= 1'b1;
    end
end
//SCCB logic
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_port_sccb_scl <= 1'b1;
    end
    else if(cstate == PHASE || cstate == FINISH)
    begin
        if(r_cyc_scl_cnt == NB_SCL_LOW - 1'b1) //scl low count full
        begin
            r_port_sccb_scl <= 1'b1;
        end
        else if(r_cyc_scl_cnt == 1'b0)
        begin
            r_port_sccb_scl <= 1'b0;
        end
    end
end
wire [7:0] w_nb_write_id = 8'h42;
wire [7:0] w_nb_read_id  = 8'h43;
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_port_sccb_sda_out <= 1'b1;
        r_port_sccb_sda_tri <= 1'b1;
    end
    else if(cstate == START)
    begin
        if(r_cyc_scl_cnt == NB_LOW_HAF - 1'b1) //start when scl high and sda pull up
        begin
            r_port_sccb_sda_out <= 1'b1;
            r_port_sccb_sda_tri <= 1'b1;
        end
    end
    else if(cstate == PHASE)
    begin
        if(r_cyc_scl_cnt == NB_LOW_HAF - 1'b1)
        begin
            if(r_phase_bit_cnt == NB_PHASE_BIT - 1'b1) //ack bit
            begin
                if(!r_shk_phse_msync && r_write_raddr_flg && r_phase_byte_cnt == 1) //read second data
                begin
                    r_port_sccb_sda_out <= 1'b1;
                    r_port_sccb_sda_tri <= 1'b1;
                end
                else 
                begin
                    r_port_sccb_sda_out <= 1'b1;
                    r_port_sccb_sda_tri <= 1'b0;
                end
            end
            else if(r_shk_phse_msync) //write
            begin
                case(r_phase_byte_cnt)
                    0: 
                        begin
                            r_port_sccb_sda_out <= w_nb_write_id[NB_PHASE_BIT-2-r_phase_bit_cnt]; 
                            r_port_sccb_sda_tri <= 1'b1;
                        end
                    1: 
                        begin
                            r_port_sccb_sda_out <= r_shk_phse_maddr[NB_PHASE_BIT-2-r_phase_bit_cnt];
                            r_port_sccb_sda_tri <= 1'b1;
                        end
                    2: 
                        begin
                            r_port_sccb_sda_out <= r_shk_phse_mdata[NB_PHASE_BIT-2-r_phase_bit_cnt];
                            r_port_sccb_sda_tri <= 1'b1;
                        end
                endcase
            end
            else if(!r_shk_phse_msync) //read
            begin
                if(!r_write_raddr_flg) //write address
                begin
                    case(r_phase_byte_cnt)
                        0:
                            begin
                                r_port_sccb_sda_out <= w_nb_write_id[NB_PHASE_BIT-2-r_phase_bit_cnt];
                                r_port_sccb_sda_tri <= 1'b1;
                            end
                        1: 
                            begin
                                r_port_sccb_sda_out <= r_shk_phse_maddr[NB_PHASE_BIT-2-r_phase_bit_cnt];
                                r_port_sccb_sda_tri <= 1'b1;
                            end
                    endcase
                end
                else if(r_write_raddr_flg) //read address
                begin
                    case(r_phase_byte_cnt)
                        0:
                            begin
                                r_port_sccb_sda_out <= w_nb_read_id[NB_PHASE_BIT-2-r_phase_bit_cnt];
                                r_port_sccb_sda_tri <= 1'b1;
                            end
                        1: 
                            begin
                                r_port_sccb_sda_out <= 1'b1;
                                r_port_sccb_sda_tri <= 1'b0;
                            end
                    endcase
                end
            end
        end
    end
    else if(cstate == FINISH)
    begin
        if(r_cyc_scl_cnt == NB_LOW_HAF - 1'b1) //bits is finish
        begin
            r_port_sccb_sda_out <= 1'b0;
            r_port_sccb_sda_tri <= 1'b1;
        end
        else if(r_cyc_scl_cnt == NB_HGH_HAF - 1'b1) //finish when scl is high pull down sda
        begin
            r_port_sccb_sda_out <= 1'b1;
            r_port_sccb_sda_tri <= 1'b1;
        end
    end
end
//output connect
assign m_port_sccb_scl     = r_port_sccb_scl;
assign m_port_sccb_sda_out = r_port_sccb_sda_out;
assign m_port_sccb_sda_tri = r_port_sccb_sda_tri;
// ----------------------------------------------------------
// sccb read to shake bus
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_shk_sccb_ready <= 1'b0;
    end
    else if(cstate == OVER)
    begin
        r_shk_sccb_ready <= 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(cstate == IDLE) //state IDLE reset
    begin
        r_shk_phse_sdata <= 1'b0;
    end
    else if(cstate == PHASE) 
    begin
        if(r_cyc_scl_cnt == NB_HGH_HAF - 1'b1 )
        begin
            if(!r_shk_phse_msync && r_write_raddr_flg && r_phase_byte_cnt == 1) //read second data
            begin
                if(r_phase_bit_cnt < NB_PHASE_BIT - 1) 
                begin
                    r_shk_phse_sdata <= {r_shk_phse_sdata[WD_SHK_DAT-2:0],m_port_sccb_sda_inp}; // << to data fifo
                end
            end
        end
    end
end
assign s_shk_sccb_ready = r_shk_sccb_ready;
assign s_shk_phse_sdata = r_shk_phse_sdata;
//========================================================
//module and task to build part of system

//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor



endmodule
