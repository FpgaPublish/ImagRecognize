`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/08 22:19:34
// Design Name: 
// Module Name: axu2cgb_top
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


module axu2cgb_top(
    input   i_port_clk_25M,
    
    output  o_port_sccb_sio_clk,
    inout   io_port_sccb_sio_d,
    
    
    output  o_port_sys_clk    ,
    output  o_port_ov7670_pwdn,
    output  o_port_ov7670_rst_n
    );

//========================================================
//function to math and logic
 
//========================================================
//localparam to converation and calculate

//========================================================
//register and wire to time sequence and combine
wire w_port_clk_25m;
//
wire w_sys_clk;
wire w_sys_rst_n;
//
wire SCCB_sio_clk;
wire SCCB_sio_out;
wire SCCB_sio_tri;
wire SCCB_sio_in ;
//


wire              SHK_sccb_valid ;
wire              SHK_sccb_ready ;
wire   [8-1:0]    SHK_phse_maddr ;
wire   [8-1:0]    SHK_phse_mdata ;
wire              SHK_phse_msync ;
wire   [8-1:0]    SHK_phse_sdata ;
//========================================================
//always and assign to drive logic and connect
assign o_port_sys_clk = i_port_clk_25M;
assign o_port_sccb_sio_clk = SCCB_sio_clk;
assign io_port_sccb_sio_d = (SCCB_sio_tri) ? SCCB_sio_out : 1'bz;
assign SCCB_sio_in = io_port_sccb_sio_d;
//========================================================
//module and task to build part of system
   BUFG BUFG_inst (
      .O(w_port_clk_25m), // 1-bit output: Clock output
      .I(i_port_clk_25M)  // 1-bit input: Clock input
   );

clk_wiz_0 u_clk_wiz_0
   (
    // Clock out ports
    .clk_out1(w_sys_clk),     // output clk_out1
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(w_sys_rst_n),       // output locked
   // Clock in ports
    .clk_in1(w_port_clk_25m));      // input clk_in1

//
// sccb_interface#(
//     .NB_VER            ( 0  ),
//     .NB_SYS_CLK        ( 10 ),
//     .WD_SHK_SYNC       ( 8  ),
//     .WD_SHK_DLAY       ( 8  ),
//     .WD_ERR_INFO       ( 4  )
// )u_sccb_interface(
//     .i_sys_clk         ( w_sys_clk         ),
//     .i_sys_rst_n       ( w_sys_rst_n       ),
//     .m_sccb_sio_clk    ( SCCB_sio_clk      ),
//     .m_sccb_sio_out    ( SCCB_sio_out      ),
//     .m_sccb_sio_tri    ( SCCB_sio_tri      ),
//     .m_sccb_sio_in     ( SCCB_sio_in       ),
//     .s_shk_sccb_wvalid ( SHK_sccb_wvalid ),
//     .s_shk_sccb_saddr  ( SHK_sccb_saddr  ),
//     .s_shk_sccb_smosi  ( SHK_sccb_smosi  ),
//     .s_shk_sccb_dmosi  ( SHK_sccb_dmosi  ),
//     .s_shk_sccb_wready ( SHK_sccb_wready ),
//     .s_shk_sccb_smiso  ( SHK_sccb_smiso  ),
//     .s_shk_sccb_dmiso  ( SHK_sccb_dmiso  ),
//     .s_err_sccb_info1  ( 0 ),
//     .m_err_sccb_info1  (   )
// );
sccb_prtc#(
    .NB_VER              ( 0 ),
    .NB_SYS_CYC          ( 10 ),
    .WD_SHK_DAT          ( 8 ),
    .WD_SHK_ADR          ( 8 ),
    .WD_ERR_INFO         ( 4 )
)u_sccb_prtc(
    .i_sys_clk           ( w_sys_clk           ),
    .i_sys_rst_n         ( w_sys_rst_n         ),
    .m_port_sccb_scl     ( SCCB_sio_clk        ),
    .m_port_sccb_sda_out ( SCCB_sio_out        ),
    .m_port_sccb_sda_tri ( SCCB_sio_tri        ),
    .m_port_sccb_sda_inp ( SCCB_sio_in         ),
    .s_shk_sccb_valid    ( SHK_sccb_valid    ),
    .s_shk_sccb_ready    ( SHK_sccb_ready    ),
    .s_shk_phse_maddr    ( SHK_phse_maddr    ),
    .s_shk_phse_mdata    ( SHK_phse_mdata    ),
    .s_shk_phse_msync    ( SHK_phse_msync    ),
    .s_shk_phse_sdata    ( SHK_phse_sdata    ),
    .m_err_sccb_info1    (     )
);


//========================================================
//expand and plug-in part with version 
reg [31:0] r_rst_delay_cnt;
always@(posedge w_sys_clk)
begin
    if(!w_sys_rst_n) //system reset
    begin
        r_rst_delay_cnt <= 1'b0; //
    end
    else if(r_rst_delay_cnt[29]) //
    begin
        r_rst_delay_cnt <= r_rst_delay_cnt;  //
    end
    else 
    begin
        r_rst_delay_cnt <= r_rst_delay_cnt + 1'b1;
    end
end
assign o_port_ov7670_rst_n = r_rst_delay_cnt[29];
assign o_port_ov7670_pwdn = 1'b0;
//========================================================
//ila and vio to debug and monitor
vio_0 u_vio_0 (
  .clk       ( w_sys_clk       ),                // input wire clk
  .probe_in0 ( SHK_sccb_valid  ),    // input wire [0 : 0] probe_in0
  .probe_in1 ( SHK_phse_maddr  ),    // input wire [7 : 0] probe_in1
  .probe_in2 ( SHK_phse_mdata  ),    // input wire [7 : 0] probe_in2
  .probe_in3 ( SHK_phse_msync  ),    // input wire [7 : 0] probe_in3
  
  .probe_out0( SHK_sccb_valid  ),  // output wire [0 : 0] probe_out0
  .probe_out1( SHK_phse_maddr  ),  // output wire [7 : 0] probe_out1
  .probe_out2( SHK_phse_mdata  ),  // output wire [7 : 0] probe_out2
  .probe_out3( SHK_phse_msync  )   // output wire [7 : 0] probe_out3
);

ila_1x5_8x1 u_ila_1x5_8x1 (
	.clk(w_sys_clk), // input wire clk

	.probe0(SCCB_sio_clk       ), // input wire [0:0]  probe0  
	.probe1(SCCB_sio_out       ), // input wire [0:0]  probe1 
	.probe2(SCCB_sio_tri       ), // input wire [0:0]  probe2 
	.probe3(io_port_sccb_sio_d ), // input wire [0:0]  probe3 
	.probe4(SHK_sccb_ready    ), // input wire [0:0]  probe4 
	.probe5(SHK_phse_sdata     )  // input wire [7:0]  probe5
);

endmodule
