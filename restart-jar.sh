#!/bin/bash

#-------------------------
# author: choway
# desc: 重启 jar 程序
# date: 2018-12-17
#-------------------------

jar_name=$1

if [ ! -n "$jar_name" ]
then
	echo "ERROR: jar name is null"
	exit 2
fi

jar_status() {
	proc_count=`ps -ef | grep $jar_name | grep -v "grep" | grep -v $0 | wc -l`
	echo $proc_count
}

start_jar() {
	echo ">>>>>>>>>> start jar >>>>>>>>>>"
	nohup java -jar -Xms4096m -Xmx4096m ${jar_name} > /dev/null 2>&1 &
	
	if [ $(jar_status) -ge 1 ]
	then
		echo "jar start success..."
	else
		echo "jar start failed..."
	fi
}

stop_jar() {
	echo ">>>>>>>>>> stop jar >>>>>>>>>>"
	jar_proc_id=`ps -ef | grep $jar_name | grep -v "grep" | grep -v $0 | awk '{print $2}'`
	echo "jar process id : $jar_proc_id"
	kill -9 $jar_proc_id
}

if [ $(jar_status) -ge 1 ]
then
	stop_jar
fi
start_jar
