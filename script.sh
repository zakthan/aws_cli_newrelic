#!/bin/bash

FILE="file.txt"

##if os is centos/redhat
result=$(yum version >/dev/null && echo $?)
if  [ "$result" -eq "0" ] 
  then
	yum install epel-release -y 
	yum install python-pip -y
	yum install jq -y
	pip install awscli --upgrade --user
	export PATH=~/.local/bin:$PATH
fi 



NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" "Name=key,Values=Name" | jq ".Tags[0].Value")
echo $NAME
NEWRELIC_NAME=$(grep display_name $FILE |tr = " "|awk '{print $2}')
echo $NEWRELIC_NAME

if  [ "$NAME" = "$NEWRELIC_NAME" ]
 then 
	echo "the same"
 else 
	echo "different"
	sed -i.bkp -s "s/$NEWRELIC_NAME/$NAME/" $FILE
fi 
