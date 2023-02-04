#ifndef MACRO_H
#define MACRO_H

//////////////////////////////////////////////////////////////////////////////////
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2022/11/22 21:56:40
// Design Name: 
// Module Name: NET_MACRO
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
#ifndef NET_MACRO_H
#define NET_MACRO_H

// ----------------------------------------------
// command to PC
#define CODE_HELLO_PS 0x12210000
#define CODE_BMP_FILE 0x12210001

// -----------------------------------------------
//add data type
typedef unsigned int   uint32;
typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned long  uint64;

// ----------------------------------------------
// error info code
#define ERR_NO_ERR   0
#define ERR_NOT_CASE 1
#define ERR_OUT_TIME 2

// -----------------------------------------------
// net struct
struct SUdpPck{
    uint32 pkg_code;     //class code
    uint32 pkg_len ;     //one pkg length
    uint32 pkg_wid ;     //current pkg width
    uint8  pkg_dat[960]; //pkg data
    uint32 pkg_xor;      //pkg xor
};

// ==========================================================
// net set
/* server port to listen on/connect to */
#define UDP_CONN_PORT 5001

#define DEFAULT_IP_ADDRESS	"192.168.120.10"
#define DEFAULT_IP_MASK		"255.255.255.0"
#define DEFAULT_GW_ADDRESS	"192.168.120.1"

#endif
#endif

