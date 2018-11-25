#!/bin/bash

FILE="file.txt"


apt install unzip jq -y 
yum install -y unzip jq

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -b ~/bin/aws
export PATH=~/bin:$PATH
NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" "Name=key,Values=Name" | jq ".Tags[0].Value")
NEWRELIC_NAME=$(grep display_name $FILE |tr = " "|awk '{print $2}')

if  [ "$NAME" = "$NEWRELIC_NAME" ]
	then
		echo "the same"
        else
	        echo "different"
	        sed -i.bkp -s "s/$NEWRELIC_NAME/$NAME/" $FILE
fi
											                  
