`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/07 22:40:13
// Design Name: 
// Module Name: tb_sccb_interface
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


module tb_sccb_interface(

    );
//clock and rst
reg i_sys_clk    = 0 ;
reg i_sys_rst_n  = 0 ;

always #5 i_sys_clk = ~i_sys_clk;
initial #1000 i_sys_rst_n = 1'b1;
//stop
initial #1000000 $stop();
//sccb
wire m_sccb_sio_clk  ;
wire m_sccb_sio_out  ;
wire m_sccb_sio_tri  ;
wire m_sccb_sio_in   ;
assign m_sccb_sio_in = 1'b1;

//shake
reg [1-1:0] s_shk_sccb_wvalid  = 0;
reg [8-1:0] s_shk_sccb_saddr   = 0;
reg [8-1:0] s_shk_sccb_smosi   = 0;
reg [8-1:0] s_shk_sccb_dmosi   = 0;
wire [1-1:0] s_shk_sccb_wready ;
wire [8-1:0] s_shk_sccb_smiso  ;
wire [8-1:0] s_shk_sccb_dmiso  ;
always 
    begin
        //read
        #100
        s_shk_sccb_wvalid = 1;
        s_shk_sccb_saddr = 8'h42;
        s_shk_sccb_smosi = 8'h66;
        s_shk_sccb_dmosi = 0;
        #10
        s_shk_sccb_wvalid = 0;
        #100000;
        //write
        #100
        s_shk_sccb_wvalid = 1;
        s_shk_sccb_saddr = 8'h43;
        s_shk_sccb_smosi = 8'h66;
        s_shk_sccb_dmosi = 1;
        #10
        s_shk_sccb_wvalid = 0;
        #100000;
    end


// sccb_interface#(
//     .NB_VER            ( 0  ),
//     .NB_SYS_CLK        ( 10 ),
//     .WD_SHK_SYNC       ( 8  ),
//     .WD_SHK_DLAY       ( 8  ),
//     .WD_ERR_INFO       ( 4  )
// )u_sccb_interface(
//     .i_sys_clk         ( i_sys_clk         ),
//     .i_sys_rst_n       ( i_sys_rst_n       ),
//     .m_sccb_sio_clk    ( m_sccb_sio_clk    ),
//     .m_sccb_sio_out    ( m_sccb_sio_out    ),
//     .m_sccb_sio_tri    ( m_sccb_sio_tri    ),
//     .m_sccb_sio_in     ( m_sccb_sio_in     ),
//     .s_shk_sccb_wvalid ( s_shk_sccb_wvalid ),
//     .s_shk_sccb_saddr  ( s_shk_sccb_saddr  ),
//     .s_shk_sccb_smosi  ( s_shk_sccb_smosi  ),
//     .s_shk_sccb_dmosi  ( s_shk_sccb_dmosi  ),
//     .s_shk_sccb_wready ( s_shk_sccb_wready ),
//     .s_shk_sccb_smiso  ( s_shk_sccb_smiso  ),
//     .s_shk_sccb_dmiso  ( s_shk_sccb_dmiso  ),
//     .s_err_sccb_info1  ( 0 ),
//     .m_err_sccb_info1  (   )
// );

sccb_prtc#(
    .NB_VER              ( 0  ),
    .NB_SYS_CYC          ( 10 ),
    .WD_SHK_DAT          ( 8  ),
    .WD_SHK_ADR          ( 8  ),
    .WD_ERR_INFO         ( 4  )
)u_sccb_prtc(
    .i_sys_clk           ( i_sys_clk           ),
    .i_sys_rst_n         ( i_sys_rst_n         ),
    .m_port_sccb_scl     ( m_sccb_sio_clk  ),
    .m_port_sccb_sda_out ( m_sccb_sio_out  ),
    .m_port_sccb_sda_tri ( m_sccb_sio_tri  ),
    .m_port_sccb_sda_inp ( m_sccb_sio_in   ),
    
    .s_shk_sccb_valid    ( s_shk_sccb_wvalid    ),
    .s_shk_sccb_ready    ( s_shk_sccb_wready    ),
    .s_shk_phse_maddr    ( s_shk_sccb_saddr    ),
    .s_shk_phse_mdata    ( s_shk_sccb_smosi    ),
    .s_shk_phse_msync    ( s_shk_sccb_dmosi[0]    ),
    .s_shk_phse_sdata    (     ),
    .m_err_sccb_info1    (     )
);




endmodule
