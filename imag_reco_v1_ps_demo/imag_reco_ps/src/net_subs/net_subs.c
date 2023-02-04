#include "net_subs.h"
#include "../MACRO.h"
#include "string.h"
struct SUdpPck pkg_send;
struct SUdpPck pkg_recv;


int decode_hello_ps()
{
	pkg_send.pkg_code = CODE_HELLO_PS;
	pkg_send.pkg_len  = 960;
	pkg_send.pkg_wid  = 1;
	//pkg_send.pkg_dat[960] = "hello PC\n\r";
	strcpy((char *)pkg_send.pkg_dat,"hello PC\n\r");
	for(int i = 0; i < 960; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
	return 0;
}

int decode_bmp_file()
{
	return 0;
}
