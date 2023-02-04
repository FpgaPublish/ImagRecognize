//////////////////////////////////////////////////////////////////////////////////
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2022/11/24 22:28:56
// Design Name: 
// Module Name: info_blck
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: vitis 2021.1
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// ==============================================
// user file include
#include "xil_printf.h"
#include "../MACRO.h"

void info_blck(uint32 n_code,char* s_info, char* s_text)
{
    xil_printf("[%x]%s: %s\n\r",n_code,s_info,s_text);
}
