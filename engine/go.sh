#!/bin/bash - 
#===============================================================================
#
#          FILE:  go.sh
# 
#         USAGE:  ./go.sh 
# 
#   DESCRIPTION:  This a engine
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: jnwang (), jnwang@linx-info.com
#       COMPANY: linx-info
#     COPYRIGHT: Copyright 2001-2014 Linx Technology Co.,Ltd.
#       CREATED: 2014年08月27日 15时34分26秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#From lib/libs.sh
REMOTE_BASE="/tmp"
REMOTE_DIR="${REMOTE_BASE}/linx_task"
REMOTE_DIR_taskcase="${REMOTE_DIR}/taskcase"
REMOTE_DIR_tasklist="${REMOTE_DIR}/tasklist"
REMOTE_DIR_result="${REMOTE_DIR}/result"
REMOTE_DIR_runtask="${REMOTE_DIR}/runtask"
REMOTE_DIR_engine="${REMOTE_DIR}/engine"


#选项后面的冒号表示该选项需要参数
while getopts "t:" arg
do
        case $arg in
                t)
                        #参数存在$OPTARG中
                        #echo "t arg:$OPTARG" ;;
                        TASKFILE=${OPTARG} ;;
                ?)
                        #当有不认识的选项的时候arg为?
                        echo "unkonw argument" exit 1 ;;
        esac
done
taskname=$(basename ${TASKFILE})

pushd ${REMOTE_DIR}
while read task
do
        if [ -x ${REMOTE_DIR_taskcase}/${task} ]; then
                ${REMOTE_DIR_taskcase}/${task} 2>&1 >result/${taskname}-${task}-`date +"%Y-%m-%d-%H:%M:%S"`.log
        fi
done <${TASKFILE}
popd
