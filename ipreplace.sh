#!/usr/bin/bash

#Get the input for ssh port no
SSH_PORT="22"

if [[ ! -z "${1}" ]]
then
		SSH_PORT="${1}"
fi

#Get the details of the IP
OLD_IP=23.15.48.96
NEW_IP=99.66.47.82

#Details of the file
FILE_NAME1="backup-mysql.sh"
FILE_PATH1="/root/bin/${FILE_NAME1}"

FILE_NAME2="backup-rsync.sh"
FILE_PATH2="/root/bin/${FILE_NAME2}"

#Dependancy Files
DOMAIN_NAME="domain_name.txt"
PASSWORD="password.txt"

#Get the input from the file and do the thing
while IFS="," read -r domain password
do
echo "Connecting to ${domain}...." | tee -a log.txt
sshpass -p ${password} ssh -p ${SSH_PORT} -T -o StrictHostKeyChecking=no root@${domain} << EOF
sed -i "s/$OLD_IP/$NEW_IP/" $FILE_PATH1
sed -i "s/$OLD_IP/$NEW_IP/" $FILE_PATH2

if [[ "${?}" -ne 0 ]]
    then
        echo "Could not replace the IP in ${domain}" | tee -a log.txt
        exit 1
	fi
EOF
done < data.csv