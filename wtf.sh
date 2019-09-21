#!/bin/bash

_VERSION="0.2.5"

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


section_developers(){
	# @SECTION: DEVELOPERS

	DEVLIST=("python2" "python3" "perl" "ruby" "java" "php" "gcc" "g++")
	SHELLS=("bash" "tcsh" "csh" "sh" "ash" "dash" "ksh" "zsh" "fish")

	python2v=`python2 -V 2> /dev/stdout` 
	python3v=`python3 --version 2> /dev/null` 
	javav=`java --version 2> /dev/null | sed '1!d'`
	perlv=`perl --version 2> /dev/null | sed '2!d'`
	rubyv=`ruby --version 2> /dev/null` 
	gccv=`gcc --version 2> /dev/null | sed '1!d'`
	gppv=`g++ --version 2> /dev/null | sed '1!d'`
	gov=`go version 2> /dev/null` 
	luav=`lua -v 2> /dev/null` 
	nodejsv=`nodejs --version 2> /dev/null` 
	opensslv=`openssl version 2> /dev/null` 

	echo -e $TEXT_BLUE" python2:$DEFAULT_COLOR $python2v"
	echo -e $TEXT_BLUE" python3:$DEFAULT_COLOR $python3v"
	echo -e $TEXT_BLUE" java:$DEFAULT_COLOR $javav"
	echo -e $TEXT_BLUE" perl:$DEFAULT_COLOR $perlv"
	echo -e $TEXT_BLUE" ruby:$DEFAULT_COLOR $rubyv"
	echo -e $TEXT_BLUE" gcc:$DEFAULT_COLOR $gccv"
	echo -e $TEXT_BLUE" g++:$DEFAULT_COLOR $gppv"
	echo -e $TEXT_BLUE" go:$DEFAULT_COLOR $gov"
	echo -e $TEXT_BLUE" lua:$DEFAULT_COLOR $luav"
	echo -e $TEXT_BLUE" nodejs:$DEFAULT_COLOR $nodejsv"
	echo -e $TEXT_BLUE" openssl:$DEFAULT_COLOR $opensslv"
}

section_services(){
	# @SECTION: SERVICES

	services=`service --status-all | sed 's/\[ - \]/[-]/g;s/\[ + \]/[+]/g;' | tr -s '\n' ',' | sed 's/\, \[/\,\[/g'`
	echo -e $TEXT_AQUA" services: "$DEFAULT_COLOR" ($services)"
	echo ""
}

section_nettools(){
	# @SECTION: NET TOOLS
	NETTOOLS=(	"iptables" "ufw" "ifconfig" "ip" "route" "tracepath" "traceroute" "ping" "wifi" "wget" "curl"\
				"nmap" "telnet" "ssh" "arp" "netstat" "nc" "netcat" "dig" "sysctl" "ftp" "tcpdump" "nslookup")
	HACKTOOLS=("xxd" "string" "file" "objdump" "gdb" "ldd" "ld" "hexeditor" "radare2")

	echo -e $TEXT_BLUE $TEXT_BOLD" - net tools -" $DEFAULT_COLOR

	# @LOOP: in net-tools
	for tool in ${NETTOOLS[@]};
	do
		cmd=`whereis $tool` # 2>/dev/null
		if [[ "$tool:" != "$cmd" ]]; then
			echo -e " [$TEXT_GREEN+$DEFAULT_COLOR] "$cmd
		fi
	done
	echo ""
}

section_hacktools(){
	# @SECTION: HACK TOOLS

	# @LOOP: in hack tools 
	echo -e $TEXT_BLUE $TEXT_BOLD" - hack tools -" $DEFAULT_COLOR
	for hack in ${HACKTOOLS[@]};
	do
		cmd=`whereis $hack`
		if [[ "$hack:" != "$cmd" ]]; then
			echo -e " [$TEXT_GREEN+$DEFAULT_COLOR] "$cmd
		fi
	done

	echo ""
}

section_tools(){
	echo -e $TEXT_AQUA "\n""Tools:" $DEFAULT_COLOR
	section_nettools
	section_hacktools
}

section_shells(){
	# @SECTION: shells

	echo -e $TEXT_BLUE $TEXT_BOLD" - shell -"$DEFAULT_COLOR
	echo -en " shells: ("

	# @LOOP: in shells
	for shell in ${SHELLS[@]};
	do
		cmd=`whereis $shell` # 2>/dev/null
		if [[ "$shell:" != "$cmd" ]]; then
			echo -en "[$TEXT_GREEN+$DEFAULT_COLOR] "$shell","
		fi
	done

	echo -e ")\n"
}

section_internet(){
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
}

section_hardware(){
	# @SECTION: Architecture PC

	echo -e $TEXT_AQUA "\n""Hardware:" $DEFAULT_COLOR
	architecture=`lscpu | sed -n "1p" | awk -F ':' '{printf "%s",$2}' | sed "s/ //g" 2> /dev/null`
	cpumodel=`lscpu | sed -n '13p' | awk -F ':' '{printf "%s",$2}' | sed 's/ //g' 2> /dev/null`
	video_product=`lshw -C display 2> /dev/null | grep "product:" | awk -F ': ' '{print $2}' 2> /dev/null`
	video_vendor=`lshw -C display 2> /dev/null | grep "vendor:" | awk -F ': ' '{print $2}' 2> /dev/null`
	kernels=`lscpu | grep '^CPU(s)' | awk -F ':' '{printf "%s", $2}' | sed 's/ //g' > /dev/null`
	MaxMHZ=`lscpu | grep 'MHz' | awk -F 'CPU max MHz:' '{printf "%s",$2}' | sed 's/ //g;s/\,0000//g' 2> /dev/null`
	MinMHZ=`lscpu | grep 'MHz' | awk -F 'CPU min MHz:' '{printf "%s",$2}' | sed 's/ //g;s/\,0000//g' 2> /dev/null`

	echo -e "CPU: "$TEXT_GREEN"$cpumodel ($architecture) ($kernels kernel) ($MinMHZ-$MaxMHZ MHz)"$DEFAULT_COLOR
	echo -e "GPU: "$TEXT_GREEN"$video_product $video_vendor"$DEFAULT_COLOR
}

section_users(){
	# @SECTOIN: USERS

	echo -e $TEXT_AQUA "\n""User:" $DEFAULT_COLOR
	roots=`cat /etc/group | grep 'sudo' | awk -F ':' '{print $4}' | tr '\n' ' '`
	awk -F ':' '{printf "%s  %s UID(%s) GID(%s)\n",$1,$6,$3,$4}' /etc/passwd
	echo -e $user_list
	echo -e "root: "$TEXT_RED"$roots"$DEFAULT_COLOR"\n"
}

whelp(){
	echo -e "usage: wtf [options?]"
	echo -e "\t--always:\t print always information (default)"
	echo -e "\t--software:\t print software information"
	echo -e "\t--hardware:\t print hardware information"
	echo -e "\t--tools:\t print fimiliar tools"
	echo -e "\t--internet:\t print inform about internet connect"
	echo -e "\t--users:\t print inform about users"
	echo -e "\t--help:\t print help page"
	echo -e "\t--version:\t print version program and exit"
	echo ""

	exit 0
}

wversion(){
	echo "wtf.sh v$_VERSION"
	exit 0
}

section_all(){
	section_software
	section_nettools
	section_hacktools
	section_internet
	section_hardware
	section_users
}

section_software(){
	echo -e $TEXT_AQUA "\n""Software:" $DEFAULT_COLOR
	section_developers
	section_services
	section_shells
}

if [ $# -lt 1 ]; then
	section_all
fi

# @SECTION: main
while [ -n "$1" ]
do
	case "$1" in
		--software)
			section_software
			;;
		--tools)
			section_tools
			;;
		--hardware)
			section_hardware
			;;
		--internet)
			section_internet
			;;
		--users)
			section_users
			;;
		--always)
			section_all
			;;
		--help)
			whelp
			;;
		--version)
			wversion
			;;
	esac
	shift
done


exit 0