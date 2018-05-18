# Zabbix-QuickInstall
![mahua](http://lachlanmiskin.com/blog/wp-content/uploads/2014/07/zabbix_logo_500x131.png)

Zabbix 快速安装文档
请使用自动注册-匹配名称注册
#linux 一键安装
* 运行zabbix_install.sh 一键安装脚本两种运行方法
1. ./zabbix_install.sh 参数$1 Zabbix服务器IP 参数$2 注册Agent名称 
#例子
./zabbix_install.sh  10.129.1.1  BJ-LIN-NGINX-GROUP-9V66
$1= zabbix服务器Ip 10.129.1.1
$2= 监控机器名称 BJ-LIN-NGINX-GROUP-9V66
# 命名规范
BJ-LIN-NGINX-GROUP-9V66
区域-系统-类型-项目组-IP （V虚拟机 P物理机  10.129.9.66虚拟机 =9V66）
   
2. ./zabbix_install.sh 运行-根据相关提示输入注册信息

#Zabbix Server 如果自动注册，请在动作---自动注册页面，进行监控机命名关联

```
############# Linx&Centos发行版 CMD ##############
curl -O https://raw.githubusercontent.com/net592/Zabbix-QuickInstall/master/linux/zabbix_install.sh;
chmod 744 zabbix_install.sh;
./zabbix_install.sh
############# AWS亚马逊&Linux CMD ##############
curl -O https://raw.githubusercontent.com/net592/Zabbix-QuickInstall/master/linux/zabbix_aws_install.sh;
chmod 744 zabbix_aws_install.sh;
./zabbix_aws_install.sh
#机器名称会追加获取EC2机器信息： InputAgentName-local-ipv4-instance-id
############################################
############# 阿里云&Linx&Ubuntu发行版 CMD##############
curl -O https://raw.githubusercontent.com/net592/Zabbix-QuickInstall/master/linux/zabbix_ubuntu_install.sh;
chmod 744 zabbix_ubuntu_install.sh;
./zabbix_ubuntu_install.sh
#机器名称会追加获取ECS机器信息： InputAgentName-local-ipv4-instance-id
############################################
```
![mahua](images/linux_setup.png)
#Windows 一键安装
* 点击安装根据提示操作（请根据需要修改服务器IP和部署安装文件路径和使用WIN共享下载）

1. install_zabbix_3.0.bat  安装脚本
2. unstall_zabbix_3.0.bat  卸载脚本

#Template 一些模版
* 后续整理
* DnsPod
