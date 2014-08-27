#!/bin/bash

j=""
k=`grep -v "^#" $1 |grep "^[[:alpha:]]"|awk '{print $1}'`

for i in $k;do 
    cat $1$j |sed s/^$i/\#$i/g >$1$i
    j=$i 
done

mv $1$i tmp.tmp
rm $1*
mv tmp.tmp $1
