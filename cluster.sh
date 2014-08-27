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

if ! [ -f ${TASKLIST} ]; then
        echo "${TASKLIST} isn't a normal file." >&2
        exit 1;
fi
if ! [ -f ${IPGROUP} ]; then
        echo "${IPGROUP} isn't a normal file." >&2
        exit 1;
fi

test 0 != `du ${TASKLIST} | awk '{print $1}'` || echo "${TASKLIST} is empty!!";exit 1
test 0 != `du ${IPGROUP} | awk '{print $1}'` || echo "${IPGROUP} is empty!!";exit 1


access -r ${TASKLIST}
if [ $? -ne 0 ]; then
        echo "${TASKLIST} can't read by permission"
fi
access -r ${IPGROUP}
if [ $? -ne 0 ]; then
        echo "${IPGROUP} can't read by permission"
fi
