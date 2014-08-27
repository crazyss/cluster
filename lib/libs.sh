#!/bin/bash - 
#===============================================================================
#
#          FILE:  libs.sh
# 
#         USAGE:  ./libs.sh 
# 
#   DESCRIPTION:  共用代码库
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: jnwang (), jnwang@linx-info.com
#       COMPANY: linx-info
#     COPYRIGHT: Copyright 2001-2014 Linx Technology Co.,Ltd.
#       CREATED: 2014年08月27日 12时28分24秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

context_check_tasklist()
{
        return 0
}

context_check_ipgroup()
{
        return 0
}


file_valid_check()
{
# $1: file
        if ! [ -f $1 ];then
                echo "file '${1}' is not a file"
                exit 1
        fi
        if ! [ -s $1 ];then
                echo "file '${1}' is empty"
                exit 2
        fi
        if ! [ -r $1 ]; then
                echo "file '${1}' can't read by permission"
                exit 3
        fi
        return 0
}>&2

check_remote_disk_space()
{
# $1: $IP
# $2: $USER
# $3: $PASSWORD
disk_usage=`sshpass -p $PASSWORD ssh $USER@$IP "df -hm /tmp"`
echo $disk_usage | awk -F "" '{print $4}'
        
}
ssh_remote_scp()
{
# $1: file need to be transfered
# $2: ipgroup file
        while read textline
        do
        IP=`echo $textline |  awk -F "," '{print $1}'`
        USER=`echo $textline |  awk -F "," '{print $2}'`
        PASSWORD=`echo $textline |  awk -F "," '{print $3}'`
        echo $IP $USER $PASSWORD 
        check_remote_disk_space $IP $USER $PASSWORD&
        done <$2
}
file_transfer()
{
# $1: ${IPGROUP} file
# $2: ${TASKLIST} file
for file in `cat $2`
do
        file_valid_check "taskcase/${file}"
        if [ $? -eq 0 ];then
                echo "taskcase/${file}"
                ssh_remote_scp "taskcase/${file}" ${1}
        fi
done
}
