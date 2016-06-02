# Check for internet connectivity every 15 sec and send out email when the connectivity goes of and email the new IP
sendEmail=0 # 0 is FALSE, 1 is TRUE
while [ 0 ]
do
ping -q -c5 www.google.com > /dev/null
if [ $? -ne 0 ]; then
sendEmail=1;
echo "No internet connection"
else    
echo "Internet connection exists"
	if [ $sendEmail -eq 1 ]; then
	   echo "Sending email"
		ip="$(traceroute -w1 www.google.com | grep 'Dynamic')"; # Find the IP of the gateway by grep'ing 'Dynamic' or 'airtelbroadband'
		sendEmail=0;
		echo $ip
		#echo "Home ADSL modem IP: "$ip | mail -s "Home ADSL modem IP" -t ttsdinesh@gmail.com		
		echo $ip | mail -s "Home ADSL IP" ttsdinesh@gmail.com
	fi	
fi
sleep 15; # Time interval in seconds
done
