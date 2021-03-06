#!/bin/bash

echo " "
echo -e "\e[00;37m*\e[00m `date` \e[00;37mStarting Supervidord\e[00m"
nohup /usr/bin/supervisord -c /etc/supervisord.conf &
sleep 6

echo " "
echo -e "\e[01;37m*\e[00m `date` \e[01;37mStarting HDFS - NameNode DataNodes\e[00m"
start-dfs.sh

echo " "
echo -e "\e[01;37m*\e[00m `date` \e[01;37mStarting YARN - Resource Manager\e[00m"
start-yarn.sh

echo " "
echo -e "\e[01;33m*\e[00m `date` \e[01;33mStarting HBase - NoSQL data store\e[00m"
start-hbase.sh
sleep 3
echo " "
echo -e "\e[00;33m*\e[00m `date` \e[00;33mStarting ZooKeeper - Centralized service\e[00m"
zkServer.sh start

$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver

echo " "
echo -e "\e[00;33m*\e[00m `date` \e[00;33mStarting Storm \e[00m"
echo " "
echo -e "\e[00;33m*\e[00m `date` \e[00;33m ninbus \e[00m"
storm nimbus
echo " "
echo -e "\e[00;33m*\e[00m `date` \e[00;33m supervisor \e[00m"
storm supervisor
echo " "
echo -e "\e[00;33m*\e[00m `date` \e[00;33m ui \e[00m"
storm ui


if [[ $1 == "bash" ]]; then
  echo " "
  echo -e "\e[01;32m*\e[00m `date` \e[01;32mShell Bash\e[00m"
  /bin/bash
fi

if [[ $1 == "-test" ]]; then
  echo " "
  echo -e "\e[00;34m*\e[00m `date` \e[00;34mtesting Hadoop MapReduce ..\e[00m"
  hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar pi 16 1000
fi

if [[ $2 == "bash" ]]; then
  echo " "
  echo -e "\e[01;31m*\e[00m `date` \e[01;31mShell Bash\e[00m"
  /bin/bash
fi


sleep 31557600
