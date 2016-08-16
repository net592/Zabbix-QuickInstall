#!/bin/bash

port=$1
state=$2

netstat -an |grep -i tcp |grep -i $port |grep -i $state |wc -l
