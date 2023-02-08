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
    inout   io_port_sccb_sio_d 

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

wire             SHK_sccb_wvalid ;
wire [8-1:0]     SHK_sccb_saddr  ;
wire [8-1:0]     SHK_sccb_smosi  ;
wire [8-1:0]     SHK_sccb_dmosi  ;

wire             SHK_sccb_wready;
wire [8-1:0]     SHK_sccb_smiso ;
wire [8-1:0]     SHK_sccb_dmiso ;
//========================================================
//always and assign to drive logic and connect
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
sccb_interface#(
    .NB_VER            ( 0  ),
    .NB_SYS_CLK        ( 10 ),
    .WD_SHK_SYNC       ( 8  ),
    .WD_SHK_DLAY       ( 8  ),
    .WD_ERR_INFO       ( 4  )
)u_sccb_interface(
    .i_sys_clk         ( w_sys_clk         ),
    .i_sys_rst_n       ( w_sys_rst_n       ),
    .m_sccb_sio_clk    ( SCCB_sio_clk      ),
    .m_sccb_sio_out    ( SCCB_sio_out      ),
    .m_sccb_sio_tri    ( SCCB_sio_tri      ),
    .m_sccb_sio_in     ( SCCB_sio_in       ),
    .s_shk_sccb_wvalid ( SHK_sccb_wvalid ),
    .s_shk_sccb_saddr  ( SHK_sccb_saddr  ),
    .s_shk_sccb_smosi  ( SHK_sccb_smosi  ),
    .s_shk_sccb_dmosi  ( SHK_sccb_dmosi  ),
    .s_shk_sccb_wready ( SHK_sccb_wready ),
    .s_shk_sccb_smiso  ( SHK_sccb_smiso  ),
    .s_shk_sccb_dmiso  ( SHK_sccb_dmiso  ),
    .s_err_sccb_info1  ( 0 ),
    .m_err_sccb_info1  (   )
);
//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor
vio_0 u_vio_0 (
  .clk(w_sys_clk),                // input wire clk
  .probe_in0 (probe_in0),    // input wire [0 : 0] probe_in0
  .probe_in1 (probe_in1),    // input wire [7 : 0] probe_in1
  .probe_in2 (probe_in2),    // input wire [7 : 0] probe_in2
  .probe_in3 (probe_in3),    // input wire [7 : 0] probe_in3
  .probe_out0(probe_out0),  // output wire [0 : 0] probe_out0
  .probe_out1(probe_out1),  // output wire [7 : 0] probe_out1
  .probe_out2(probe_out2),  // output wire [7 : 0] probe_out2
  .probe_out3(probe_out3)  // output wire [7 : 0] probe_out3
);

endmodule
