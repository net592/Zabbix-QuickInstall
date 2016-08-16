#!/bin/bash

help()
{
  echo "usage: disk_io_monitor.sh -i interval"
  exit
}

build_metrics()
{
  iostat=$(iostat -dxk 1 3)
  #iostat=$(cat iostat.txt)

  #echo "$iostat"

  record=$(echo "$iostat" |awk 'BEGIN { RS="util" } { if (NR == 4) print $0 }')

  echo "$record" | grep -E "\bsd[a-z]\b|\bvd[a-z]\b|\bdf[a-z]\b" |awk '
  {
    device = $1
    print "- disk.status[" device ",rrqm]", $2
    print "- disk.status[" device ",wrqm]", $3
    print "- disk.status[" device ",rps]", $4
    print "- disk.status[" device ",wps]", $5
    print "- disk.status[" device ",rkBps]", $6
    print "- disk.status[" device ",wkBps]", $7
    print "- disk.status[" device ",avgrq-sz]", $8
    print "- disk.status[" device ",avgqu-sz]", $9
    print "- disk.status[" device ",await]", $10
    print "- disk.status[" device ",util]", $12
  }
 '
}

[ $# -ne 2 ] && help

while [ -n "$1" ]; do
case "$1" in
  -i) interval=$2; shift 2;;
   *) help;;
esac
done

while true; do
  metrics=$(build_metrics)

  #echo "$metrics"
  echo "$metrics" | zabbix_sender -c /etc/zabbix/zabbix_agentd.conf -i -

  sleep $interval
done
