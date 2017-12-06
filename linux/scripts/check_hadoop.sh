#!/bin/bash 
#scripts for tcp status By Zeming
function namenode { 
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i namenode|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
(su - hadoop -c "/usr/local/hadoop/sbin/hadoop-daemon.sh start namenode")
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
function datanode {
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i datanode|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
function resourcemanager {
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i datanode|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
function nodemanager {
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i nodemanager|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
function master {
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i HMaster|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
function regionserver {
NUM=$(su - hadoop -c "/usr/local/java/bin/jps |grep -i regionserver|wc -l")
if [[ $NUM -eq 1 ]];then
echo "$NUM"
else
echo "$NUM" 
fi
#/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'
}
$1
