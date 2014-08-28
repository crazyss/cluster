#!/bin/bash
#注释inet.conf文件中所有未关闭的服务

do_task()
{
        j=""
        k=`grep -v "^#" $1 |grep "^[[:alpha:]]"|awk '{print $1}'`

        for i in $k;do 
                cat $1$j |sed s/^$i/\#$i/g >$1$i
                j=$i 
        done

        mv $1$i tmp.tmp
        rm $1*
        mv tmp.tmp $1
}

FILENAME="/etc/inetd.conf"

if [ -f ${FILENAME} ];then
        cp ${FILENAME}{,.bak.linx}
        do_task ${FILENAME}
        exit 0
else
        echo "no ${FILENAME} exist. --PASS--"
        exit 0
fi
