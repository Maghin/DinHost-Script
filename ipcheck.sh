#/bin/sh
 
##########################################
# CONFIG GOES HERE
#
 
HOST=*hostname_to_update*
LOGIN=*DynHost_account*
PASSWORD=*DynHost_password*
 
PATH_APP=`dirname $0`
PATH_LOG=$PATH_APP/log
PATH_FILE_OLD_IP=$PATH_APP/old_ip

#
# CONFIG END
##########################################

#prevent error when ipcheck.err exists
rm -f $PATH_APP/ipcheck.err

IP=`lynx -dump http://monip.org | grep 'IP' | sed 's/.*: //;'`
OLD_IP=`cat $PATH_FILE_OLD_IP`

echo > $PATH_LOG
echo "Run dynhost" >> $PATH_LOG
date >> $PATH_LOG

echo "Current IP" >> $PATH_LOG
echo "$IP" >> $PATH_LOG
echo "Previous IP" >> $PATH_LOG
echo "$OLD_IP" >> $PATH_LOG

if [ -z $IP ]; then
	echo "No IP retrieved" >> $PATH_LOG
else
	if [ "$OLD_IP" != "$IP" ]; then
		echo "IP has changed" >> $PATH_LOG
		RESULT=""
		RESULT=`$PATH_APP/ipcheck.py -a $IP $LOGIN $PASSWORD $HOST`
		echo "ipcheck returns : $RESULT" >> $PATH_LOG
		if [ -z "$RESULT" ]; then
			echo "Success" >> $PATH_LOG
			echo -n "$IP" > $PATH_FILE_OLD_IP
		else
			echo "Error : $RESULT" >> $PATH_LOG
		fi
	else
		echo "No IP change" >> $PATH_LOG
	fi
fi
