#!/bin/bash - 
#===============================================================================
#
#          FILE:  cluster.sh
# 
#         USAGE:  ./cluster.sh 
# 
#   DESCRIPTION:  main program
#                 本程序做为整个框架的功能引擎
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: jnwang (), jnwang@linx-info.com
#       COMPANY: linx-info
#     COPYRIGHT: Copyright 2001-2014 Linx Technology Co.,Ltd.
#       CREATED: 2014年08月27日 11时54分19秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

. lib/libs.sh

usage()
{
        echo ""
        echo Usage :
        echo $0 -t tasklist -i ipgroup
}

SSHPASS=`which sshpass`

if ! [ -x ${SSHPASS} ] ;then
        echo "Program Error: 'sshpass' not install" >&2
        exit 1;
fi

if [ $# -lt 1 ]; then
        echo "Program Error: parameter missing" >&2
        usage
        exit 0;
fi

#选项后面的冒号表示该选项需要参数
while getopts "t:i:" arg
do
        case $arg in
                t)
                        #参数存在$OPTARG中
                        #echo "t arg:$OPTARG" ;;
                        TASKLIST=${OPTARG} ;;
                i)
                        #参数存在$OPTARG中
                        #echo "i arg:$OPTARG" ;;
                        IPGROUP=${OPTARG} ;;

                ?)
                        #当有不认识的选项的时候arg为?
                        echo "unkonw argument" exit 1 ;;
        esac
done

file_valid_check ${TASKLIST}
file_valid_check ${IPGROUP}


context_check_tasklist ${TASKLIST}
context_check_ipgroup ${IPGROUP}


file_transfer ${IPGROUP} ${TASKLIST}
