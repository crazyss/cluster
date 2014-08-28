#!/bin/bash
#修改文件的特定行

do_task()
{
        A="PASS_MAX_DAYS.*99999"
        B="PASS_MAX_DAYS   "
        sed -i "s/$A/$B$1/g" $2
}


FILENAME="/etc/login.defs"
MAX_DAYS=90

if [ -f ${FILENAME} ];then
        cp ${FILENAME}{,.bak.linx}
        do_task ${MAX_DAYS} ${FILENAME}
        exit 0
else
        echo "no ${FILENAME} exist. --PASS--"
        exit 0
fi
