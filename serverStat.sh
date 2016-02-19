# USAGE
# serverStat.sh debug 
# debug parameters will display the commands used to get the statistics 


echo "###########################################################################################"
echo -e "\e[36m                               Author\e[0m" 
echo -e "\e[34m                       ttsdinesh@gmail.com\e[0m"
echo "###########################################################################################"

debug="false"
help="false"


if [ ! -z "$1" ] && [ $1 = "debug" ]; then
	debug="true"
fi;


echo -e "\e[32m-------------------------- Access details --------------------------\e[0m"

#Hostname
echo -e "\e[1mHostname\e[0m" `hostname`
if [ $debug = "true" ]; then
	echo '[DEBUG]hostname'
fi;

# IP and interface
echo -e "\n"
echo -e "\e[1mInterfaces and IP details\e[0m"
ifconfig | egrep -B1  'inet |$'\t''

if [ $debug = "true" ]; then
	echo "[DEBUG]ifconfig | egrep -B1  'inet |$'\t''"
fi;

echo -e "\n"


echo -e "\e[32m-------------------------- Memory and Disk --------------------------\e[0m"

echo -e "\e[1mDisk layout\e[0m"
df -h

if [ $debug = "true" ]; then
	echo "[DEBUG]df -h"
fi;
echo -e "\n"
echo -e "\e[1mInodes statistics\e[0m"
df -ih

if [ $debug = "true" ]; then
	echo "[DEBUG]df -ih"
fi;



echo -e "\n"
echo -e "\e[1mMemory statistics\e[0m"
free -m
if [ $debug = "true" ]; then
	echo "[DEBUG]free -m"
fi;

echo -e "\n"
echo -e "\e[1mTop 3 memory consuming processes\e[0m"
ps aux | sort -rk 3 | head -n 3
if [ $debug = "true" ]; then
	echo "[DEBUG]ps aux | sort -rk 3 | head -n 3"
fi;


echo -e "\n"
echo -e "\e[32m-------------------------- CPU --------------------------\e[0m"
echo -e "\e[1mTotal number of CPUs\e[0m" `nproc`
if [ $debug = "true" ]; then
	echo "[DEBUG]nproc"
fi;

echo -e "\n"
echo -e "\e[1mProcessor details\e[0m"
cat /proc/cpuinfo | grep name
if [ $debug = "true" ]; then
	echo "[DEBUG]cat /proc/cpuinfo | grep name"
fi;

echo -e "\n"
echo -e "\e[1mTop 3 CPU consuming processes\e[0m"
ps aux | sort -rk 3,4 | head -n 3
if [ $debug = "true" ]; then
	echo "[DEBUG]ps aux | sort -rk 3,4 | head -n 3"
fi;

echo -e "\n"
echo -e "\e[32m-------------------------- Services --------------------------\e[0m"
#sshd service
if (( $(ps -ef | grep -v grep | grep sshd | wc -l) > 0 ))
then
	echo "-Sshd service running"
else
	echo -e "\e[31m-Sshd service either not running or not installed\e[0m"
fi

if [ $debug = "true" ]; then
	echo "[DEBUG] (ps -ef | grep -v grep | grep sshd | wc -l) > 0"
fi;

#Snmp service
if (( $(ps -ef | grep -v grep | grep snmpd | wc -l) > 0 ))
then
	echo "-Snmpd service running"
else
	echo -e "\e[31m-Snmpd service either not running or not installed\e[0m"
fi

if [ $debug = "true" ]; then
	echo "[DEBUG] (ps -ef | grep -v grep | grep snmpd | wc -l) > 0"
fi;

#iptables
if (( $(ps -ef | grep -v grep | egrep 'iptables|ip6tables' | wc -l) > 0 ))
then
	echo -e "\e[31m-iptables running \e[0m"
else
	echo -e "-iptables are disabled"
fi

if [ $debug = "true" ]; then
	echo "[DEBUG] (ps -ef | grep -v grep | egrep 'iptables|ip6tables' | wc -l) > 0"
fi;


#ntpd service
if (( $(ps -ef | grep -v grep | grep ntpd | wc -l) > 0 ))
then
	echo "-Ntpd service running"
else
	echo -e "\e[31m-Ntpd service either not running or not installed\e[0m"
fi

if [ $debug = "true" ]; then
	echo "[DEBUG] (ps -ef | grep -v grep | grep ntpd | wc -l) > 0"
fi;


echo -e "\n"
echo -e "\e[32m-------------------------- MISC --------------------------\e[0m"
#Check SE LINUX
seLinux=`getenforce`

if [ $seLinux = "Enforcing" ];
then
	echo -e "\e[31m-SE Linux not disabled\e[0m"
else
	echo "- SE Linux is disabled"
fi
if [ $debug = "true" ]; then
	echo "[DEBUG]getenforce"
fi;

#check snmp configurations
echo -e "\n"
echo -e "\e[1mChecking snmp configurations\e[0m"
if(( $(snmpwalk -v2c -c public localhost system | awk -F'::' '{print $2}'| wc -l) > 0 )) 
then
	echo -e "snmp is configured"
else
	echo -e "\e[31msnmp is not configured\e[0m"
fi


#check ssh-key Config
echo -e "\n"
echo -e "\e[1mChecking ssh-key Configurations\e[0m"
if [ -f "$HOME/.ssh/id_rsa" ]
then
	echo -e "ssh-key found."
else
	echo -e "\e[31mssh-key not found.\e[0m"
fi 


if [ -f "$HOME/.ssh/id_rsa.pub" ]
then
	echo -e "ssh-key.public found."
else
	echo -e "\e[31mssh-key.public not found.\e[0m"
fi 




echo -e "\n\e[1mEnd of script\e[0m"
echo  -e "-------------------------- THE END --------------------------"i

