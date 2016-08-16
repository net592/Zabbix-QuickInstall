#!/bin/bash

disks=($(cat /proc/diskstats | grep -E "\bsd[a-z]\b|\bvd[a-z]\b|\bdf[a-z]\b" | awk '{print $3}'))

echo '{'
echo '  "data" : ['

count=${#disks[@]}
last=$(expr $count - 1)

for ((i=0;i<count;++i))
{
  if [ $i -ne $last ]; then
    echo "    { \"{#DISK_NAME}\" : \"${disks[i]}\" },"
  else
    echo "    { \"{#DISK_NAME}\" : \"${disks[i]}\" }"
  fi
}

echo '  ]'
echo '}'
