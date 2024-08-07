#!/bin/bash

USER_ID=$1
GROUP_ID=$2
USERNAME=$3

if id -u $USER_ID &>/dev/null; then
    existing_user=$(getent passwd $USER_ID | cut -d: -f1)
    group_name=$(id -gn $existing_user)
    usermod -l $USERNAME $existing_user
    groupmod -n $USERNAME $group_name
    usermod -d /home/$USERNAME -m $USERNAME
else
    groupadd -g $GROUP_ID $USERNAME
    useradd -m -u $USER_ID -g $GROUP_ID $USERNAME
fi

chown -R $USERNAME:$USERNAME /home/$USERNAME
