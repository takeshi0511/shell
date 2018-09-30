#!/bin/bash                                                                                                                                 

### Define of Array ###
declare -A user_id

user_id[""]=""
user_id[""]=""
user_id[""]=""

### Server Setup Logic ###
for KEY in "${!user_id[@]}"
do

        # Create group and user
        groupadd ${KEY}
        useradd -g ${KEY} -d /home/${KEY} -s /bin/bash -m ${KEY}

        if [ "`grep "${KEY} ALL=(ALL) NOPASSWD: ALL" /etc/sudoers`" != "${KEY} ALL=(ALL) NOPASSWD: ALL" ]; then
                echo "${KEY} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
        fi

        # Set up SSH
        mkdir -p /home/${KEY}/.ssh
        curl https://gitlab.com/${user_id[${KEY}]}.keys > /home/${KEY}/.ssh/authorized_keys 2>/dev/null

        # if Failed to curl, Display Error Message.
        if [ $? != 0 ]; then
                echo "Fatal Error: Faild to curl command. Try Again!!!"
        fi

        chown -R ${KEY}:${KEY} /home/${KEY}/.ssh
        chmod -R 700 /home/${KEY}/.ssh

        if [ "`grep "AllowUsers ${KEY}" /etc/ssh/sshd_config`" != "AllowUsers ${KEY}" ]; then
                echo AllowUsers ${KEY} >> /etc/ssh/sshd_config
        fi

done

systemctl restart sshd
echo "Initial Setup Completed."

