#!/bin/bash

_VERSION="0.1"

TEXT_BOLD="\e[1m"

TEXT_GREEN="\e[32m"
TEXT_RED="\e[31m"
TEXT_BLUE="\e[34m"
TEXT_AQUA="\e[36m"
TEXT_PURPLE="\e[35m"

TEXT_ERROR=$TEXT_RED
TEXT_WARNING=$TEXT_PURPLE

DEFAULT_COLOR="\e[0m"

# SECTION BASE COMMENT
# SECTION DEVELOPERS IS CREATED !
# will create section network

HACKTOOLS=("xxd" "string" "file" "objdump" "gdb" "ldd" "ld" "hexeditor")
NETTOOLS=(	"iptables" "ufw" "ifconfig" "ip" "route" "tracepath" "traceroute" "ping" "wifi" "wget" "curl"\
			"nmap" "telnet" "ssh" "arp" "netstat" "nc" "netcat" "dig" "sysctl" "ftp" "tcpdump" "nslookup")
DEVLIST=("python2" "python3" "perl" "ruby" "java" "php" "gcc" "g++")
SHELLS=("bash" "tcsh" "csh" "sh" "ash" "dash" "ksh" "zsh" "fish")

# @SECTION: DEVELOPERS
echo -e $TEXT_AQUA "\n == DEVELOPERS == \n" $DEFAULT_COLOR
echo -e $TEXT_BLUE $TEXT_BOLD" - programming -" $DEFAULT_COLOR

python2v=`python2 -V 2> /dev/stdout` 2> /dev/null
python3v=`python3 --version` 2> /dev/null
javav=`java --version | sed '1!d'` 2> /dev/null
perlv=`perl --version | sed '2!d'` 2> /dev/null
rubyv=`ruby --version` 2> /dev/null
gccv=`gcc --version | sed '1!d'` 2> /dev/null
gppv=`g++ --version | sed '1!d'` 2> /dev/null
gov=`go version` 2> /dev/null
luav=`lua -v` 2> /dev/null
nodejsv=`nodejs --version` 2> /dev/null
opensslv=`openssl version` 2> /dev/null

echo -e $TEXT_BLUE"python2:$DEFAULT_COLOR $python2v"
echo -e $TEXT_BLUE"python3:$DEFAULT_COLOR $python3v"
echo -e $TEXT_BLUE"java:$DEFAULT_COLOR $javav"
echo -e $TEXT_BLUE"perl:$DEFAULT_COLOR $perlv"
echo -e $TEXT_BLUE"ruby:$DEFAULT_COLOR $rubyv"
echo -e $TEXT_BLUE"gcc:$DEFAULT_COLOR $gccv"
echo -e $TEXT_BLUE"g++:$DEFAULT_COLOR $gppv"
echo -e $TEXT_BLUE"go:$DEFAULT_COLOR $gov"
echo -e $TEXT_BLUE"lua:$DEFAULT_COLOR $luav"
echo -e $TEXT_BLUE"openssl:$DEFAULT_COLOR $opensslv"

# @SECTION: SERVICES
services=`service --status-all | sed 's/\[ - \]/[-]/g;s/\[ + \]/[+]/g;' | tr -s '\n' ',' | sed 's/\, \[/\,\[/g'`
echo -e $TEXT_AQUA"services: "$DEFAULT_COLOR" ($services)"


echo ""
echo -e $TEXT_BLUE $TEXT_BOLD" - net tools -" $DEFAULT_COLOR

# @LOOP: in net-tools
for tool in ${NETTOOLS[@]};
do
	cmd=`whereis $tool` # 2>/dev/null
	if [[ "$tool:" != "$cmd" ]]; then
		echo -e " [$TEXT_GREEN+$DEFAULT_COLOR] "$cmd
	fi
done

# @LOOP: in hack tools 
echo ""
echo -e $TEXT_BLUE $TEXT_BOLD" - hack tools -" $DEFAULT_COLOR
for hack in ${HACKTOOLS[@]};
do
	cmd=`whereis $hack`
	if [[ "$hack:" != "$cmd" ]]; then
		echo -e " [$TEXT_GREEN+$DEFAULT_COLOR] "$cmd
	fi
done

echo ""
echo -e $TEXT_BLUE $TEXT_BOLD" - shell -"$DEFAULT_COLOR
echo -en "shells: ("

# @LOOP: in shells
for shell in ${SHELLS[@]};
do
	cmd=`whereis $shell` # 2>/dev/null
	if [[ "$shell:" != "$cmd" ]]; then
		echo -en "[$TEXT_GREEN+$DEFAULT_COLOR] "$shell","
	fi
done
echo -en ")\n"


# @SECTION: INTERNET
echo -e $TEXT_AQUA "\nINTERNET:" $DEFAULT_COLOR
local_ip=`hostname -I | sed 's/[ \t]*$//'`
global_ip=`curl ident.me 2> /dev/null`

info=`curl http://ip-api.com/line/$global_ip 2> /dev/null` 2>/dev/null
country=`echo "$info" | sed '2!d'` 2>/dev/null
region=`echo "$info" | sed '5!d'` 2>/dev/null
city=`echo "$info" | sed '6!d'` 2>/dev/null
zip=`echo "$info" | sed '7!d'` 2>/dev/null
lat=`echo "$info" | sed '8!d'` 2>/dev/null
lon=`echo "$info" | sed '9!d'` 2>/dev/null
timezone=`echo "$info" | sed '10!d'` 2>/dev/null
isp=`echo "$info" | sed '11!d'` 2>/dev/null
organization=`echo "$info" | sed '12!d'` 2>/dev/null
asn=`echo "$info" | sed '13!d'` 2>/dev/null

echo -e "  Global IP [$global_ip] Local IP [$local_ip]"
echo -e "  $country, $region, $city $zip, Geo [$lat $lon]"
echo -e "  provider: ($isp, $organization, $asn)"
echo ""


# @SECTION: Architecture PC
echo -e "\n -- Hardware -- "
architecture=`lscpu | sed -n "1p" | awk -F ':' '{printf "%s",$2}' | sed "s/ //g" 2> /dev/null`
cpumodel=`lscpu | sed -n '13p' | awk -F ':' '{printf "%s",$2}' | sed 's/ //g' 2> /dev/null`
video_product=`lshw -C display 2> /dev/null | grep "product:" | awk -F ': ' '{print $2}' 2> /dev/null`
video_vendor=`lshw -C display 2> /dev/null | grep "vendor:" | awk -F ': ' '{print $2}' 2> /dev/null`
kernels=`lscpu | grep '^CPU(s)' | awk -F ':' '{printf "%s", $2}' | sed 's/ //g' > /dev/null`
MaxMHZ=`lscpu | grep 'MHz' | awk -F 'CPU max MHz:' '{printf "%s",$2}' | sed 's/ //g;s/\,0000//g' 2> /dev/null`
MinMHZ=`lscpu | grep 'MHz' | awk -F 'CPU min MHz:' '{printf "%s",$2}' | sed 's/ //g;s/\,0000//g' 2> /dev/null`

echo -e "CPU: "$TEXT_GREEN"$cpumodel ($architecture) ($kernels kernel) ($MinMHZ-$MaxMHZ MHz)"$DEFAULT_COLOR
echo -e "GPU: "$TEXT_GREEN"$video_product $video_vendor"$DEFAULT_COLOR


# @SECTOIN: USERS
echo -e "\n --- User (list) --- "
roots=`cat /etc/group | grep 'sudo' | awk -F ':' '{print $4}' | tr '\n' ' '`
awk -F ':' '{printf "%s  %s UID(%s) GID(%s)\n",$1,$6,$3,$4}' /etc/passwd
echo -e $user_list
echo -e "root: "$TEXT_RED"$roots"$DEFAULT_COLOR"\n"

exit 0