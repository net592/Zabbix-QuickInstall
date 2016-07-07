# Zabbix-QuickInstall
![mao](http://image.lxway.com/upload/c/90/c90ec90564a371aba08fb39d7bd96ff7_thumb.jpg) 
Zabbix 快速安装文档
请使用自动注册-匹配名称注册
#linux 一键安装
* 运行zabbix_install.sh 一键安装脚本两种运行方法
1. ./zabbix_install.sh 参数Zabbix服务器IP 参数注册Agent名称
2. ./zabbix_install.sh 运行
```
curl -O https://raw.githubusercontent.com/net592/Zabbix-QuickInstall/gh-pages/linux/zabbix_install.sh;\
chmod 744 zabbix_install.sh;\
./zabbix_install.sh
############################################
                                             
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
 欢迎使用Zabbix Agent Install 脚本V1.0 By Zeming
 Part 1:Setup envurment 
 当前目录为:/root 本机ip为:12.12.12.52 安装版本:3.0.3
 Please Zabbix-Server-IP: 1.2.3.4
 zabbix服务器ip为:1.2.3.4 
 Please Input zabbix-Agent-HostName: ZABBIX_HOSTNAME_AABB
 Zabbix ServerIP:1.2.3.4 
 HostName:ZABBIX_HOSTNAME_AABB 
  Confirm to Start the Installation  (yes or no): y
```
#Windows 一键安装
* 点击安装根据提示操作（根据需要修改服务器IP和部署安装文件路径和共享）

1. install_zabbix_3.0.bat  安装脚本
2. unstall_zabbix_3.0.bat  卸载脚本
