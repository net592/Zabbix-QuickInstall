#!/bin/sh
stty erase ^h
cat << EOF
                                             
                :,;;iiiii;i;.:i..            
             .,iii;i;;;;;;;i;ii;             
            ;ii;;;;;;;;;;;;;;;ivl;           
          .i;;;;;;;;;;;;;;;;;;;i;vi          
         ,i;;;;,;,;,;;;;;,;:,.:.,;ii.        
        ,i;;,ii;,:..:;;;,,,iijLMl;;il        
       .i;;;;UDOSqZCv,;,;q8qOXJUv,;,il       
       i;;;;;,.  :iMv;;;;i.     .;;;,Y;      
      ;;;;;;;,.;@q  ,;;;; .;yL2Sc,;;;;L      
      ;;;;;;;,.@B@;:;;;;:Q@@2Uili;;;;;l;     
     .i;;;;,;.,@@C..,:;::;MISSSl.:;,;,li     
     ,;;;;;lVy:;;..;,,:,., ..;ll,yVy;;iV     
     ,i;;;;;ii;.,:;SB66Z8C;:;:,:;;i;;:iY     
     ;;;;;;;,;;;;;,;CED6c;:;;;;;,;:;;;iV     
     ,i;;;;;;;;;;;;.::;.::;;;;;;;;i;i;il     
     ;;;;;;;;;;;;;;;;;,;;;;;;;;i;i;i;iiY     
     ,i;iii;;;;;;;;;;;;;;;;;;;iii;i;i;vl     
     ,ivilvyii;i;i;i;iii;i;i;iiliviviiiv     
     i    ..,.. . . . . . . .......    y     
    F@Ii                             VGB0    
   X@GZ8EY       ;2I::.V2,        lqBQZI@2   
  c@6GMIOB8t .lq8@@B.  6B@EC;  ;MBBQ2IMIq@F  
 v@D213K3KS8B8@QSI8v   ;E06EBQQB8O3MCF313Z@M 
l@BEiU22F2F330KCFSK     iDM2CSSGF2F3FCMF;Z8@i
 ;B@KXGMCF2KC13F23I     Fq3K21CFCKCKCKGKKB@y 
  .DlOOICIMIM3CIKGS8i  EEGC3KIMICIMIM32ZjD;  
     UIJtJtJtJ1J1XF2EUqqFJ1JtJtJtJtc1XCK     
EOF
echo -e "\e[1;33m 欢迎使用Zabbix Agent Install 脚本V1.0 By Zeming\e[0m"
sleep 1
echo -e "\033[42;37m Part 1:Setup envurment \033[0m"

zabbixdir=`pwd`
zabbix_version=3.2.5
ip=`ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'`


ServerIP=$1
HostName=$2
if [ ! -n "$1" ]; then
    echo -e "\033[32m 当前目录为:$zabbixdir 本机ip为:$ip 安装版本:$zabbix_version\033[0m"
    echo -ne "\033[32m Please Zabbix-Server-IP: \033[0m"
    read ServerIP
    echo -e "\033[32m zabbix服务器ip为:$ServerIP \033[0m"

    echo -ne "\033[32m Please Input zabbix-Agent-HostName: \033[0m"
    read HostName
    echo -e "\033[32m Zabbix ServerIP:$ServerIP \n HostName:$HostName \033[0m"

    echo -ne "\e[1;31m  Confirm to Start the Installation  (yes or no): \e[0m"
    read isY
    if [ "${isY}" != "y" ] && [ "${isY}" != "Y" ] && [ "${isY}" != "yes" ] && [ "${isY}" != "YES" ];then
    exit 1
    fi
else
    echo -e "\033[32m Zabbix ServerIP:$ServerIP \n HostName:$HostName \033[0m"
fi


echo -e "\033[42;37m Part 2:Yum Setup gcc \033[0m"
echo "安装相关组件"
yum install -y ntpdate gcc gcc-c++ wget unzip
echo "同步服务器时间"
ntpdate cn.pool.ntp.org
echo "创建zabbix用户"
groupadd zabbix
useradd -g zabbix zabbix


echo -e "\033[42;37m Part 3:Download Zabbix Pack \033[0m"
echo "安装zabbix-agent"
sleep 2

if [ ! -f "$zabbixdir/zabbix-${zabbix_version}.tar.gz" ]; then
   #wget http://netix.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
   #wget http://120.52.73.48/jaist.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
   #wget http://tenet.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
   #wget https://jaist.dl.sourceforge.net/project/zabbix/ZABBIX Latest Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
   #wget --no-check-certificate https://jaist.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$zabbix_version/zabbix-${zabbix_version}.tar.gz
   #wget http://$ServerIP/zabbix/zabbix-${zabbix_version}.tar.gz
   wget http://omwdjgaw1.bkt.clouddn.com/zabbix/zabbix-${zabbix_version}.tar.gz
else
   echo -ne "\033[32m zabbix-${zabbix_version}.tar.gz文件已存在 \033[0m"
   tar zxvf $zabbixdir/zabbix-${zabbix_version}.tar.gz
fi

tar zxvf $zabbixdir/zabbix-${zabbix_version}.tar.gz
cd $zabbixdir/zabbix-${zabbix_version}
echo `pwd`
./configure --prefix=/usr/local/zabbix/ --enable-agent
sleep 3
make
make install

echo -e "\033[42;37m Part 4:Config Zabbix File \033[0m"
echo -ne "\033[32m Config agent configure file \033[0m"
echo "配置zabbix server ip为 $ServerIP"
echo "配置zabbix HostName ip为 $HostName"
sed -i "s/Hostname=Zabbix server/Hostname=$HostName/g" /usr/local/zabbix/etc/zabbix_agentd.conf #设置主机名
sed -i "s/Server=127.0.0.1/Server=$ServerIP/g" /usr/local/zabbix/etc/zabbix_agentd.conf #设置Server地址
sed -i "s/# AllowRoot=0/AllowRoot=1/g" /usr/local/zabbix/etc/zabbix_agentd.conf #开启root权限
sed -i "s/ServerActive=127.0.0.1/ServerActive=$ServerIP/g" /usr/local/zabbix/etc/zabbix_agentd.conf  #设置Active服务器地址
sed -i "s/# EnableRemoteCommands=0/EnableRemoteCommands=1/g" /usr/local/zabbix/etc/zabbix_agentd.conf #设置启用远程命令功能
sed -i "s/# HostMetadataItem=/HostMetadataItem=system.uname/g" /usr/local/zabbix/etc/zabbix_agentd.conf #设置HostMetadataItem
sed -i "s/# Include=$/Include=\/usr\/local\/zabbix\/etc\/zabbix_agentd.conf.d\/*.conf/g" /usr/local/zabbix/etc/zabbix_agentd.conf 
echo -ne "\033[32m Down GitHUB Config \033[0m"
cd $zabbixdir
wget https://github.com/net592/Zabbix-QuickInstall/archive/master.zip

unzip -o master.zip
\cp -fr $zabbixdir/Zabbix-QuickInstall-master/linux/* /usr/local/zabbix/etc/
chown zabbix:zabbix /usr/local/zabbix/etc/scripts/*
chmod 744 /usr/local/zabbix/etc/scripts/*

echo "创建启动init"
cp $zabbixdir/zabbix-${zabbix_version}/misc/init.d/tru64/zabbix_agentd /etc/init.d/
chmod +x /etc/init.d/zabbix_agentd
sed -i "s:DAEMON=/usr/local/sbin/zabbix_agentd:DAEMON=/usr/local/zabbix/sbin/zabbix_agentd:g" /etc/init.d/zabbix_agentd
echo "启动zabbix_agentd"
echo -e "#Zabbix_Agent Service \n/etc/init.d/zabbix_agentd restart" >>/etc/rc.local 
/etc/init.d/zabbix_agentd restart
echo -e "\033[42;37m Part 5:Check Zabbix Status \033[0m"
PROC_NAME=zabbix_agentd
ProcNumber=`ps -ef |grep $PROC_NAME|grep -v grep|wc -l`
if [ $ProcNumber -le 0 ];then
   echo -e "\033[41;37m Zabbix_agentd installed Failed Status Stop \033[0m"
else
   echo -e "\033[42;37m Zabbix_agentd installed Successfully Status Running \033[0m"
fi
