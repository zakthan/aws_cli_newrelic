# aws_cli_newrelic
Author Athanasios Zakopoulos

- This script installs aws cli and checks if display_name of a config file equals to resource-id. 
  If it is not equals it changes he display name value to the value of resource_id and keeps a backup of the file
- Run this script as root
- aws configure is part of the script and run interctively
- If linux distro is red hat/centos/ubuntu/debian/amazon linux script installs jq and unzip that are needed for this script to run
- If linux distro is not one of the above jq and unzip need to be installed manually
-For script to run correct $FILE needs to be changed with the desired config file
