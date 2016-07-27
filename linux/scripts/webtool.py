#!/usr/bin/env python
#coding:utf-8
import os,sys,json
import MySQLdb
#将要监控的web站点url添加到urllist列表

try:
    conn = MySQLdb.connect(host='10.129.9.121',user='root',passwd='nji9NJI(',db='saltoneops',charset="utf8")
    cursor = conn.cursor()
    cursor.execute("SELECT t2.name, t2.type, CONCAT(t4.ip_add,':',t1.port), t1.code, t1.app_path, t1.enabled From opsapp_apps t1 INNER JOIN opsapp_appname t2 on  t2.id = t1.name_id INNER JOIN opsapp_apps_ip_add t3 on t1.id = t3.apps_id INNER JOIN opsapp_serverip t4 on t4.id = t3.serverip_id WHERE t2.type='WebSite';")
    results = cursor.fetchall()
except MySQLdb.Error,e:
    print "Mysql Error %d: %s" % (e.args[0], e.args[1])
#这个函数主要是构造出一个特定格式的字典，用于zabbix
def web_site_discovery():
    web_list=[]
    web_dict={"data":None}
    for r in results:
            if r[3] is 0:
               break
            url_dict={}
            url_dict["{#SITENAME}"]=r[0]
            url_dict["{#IP}"]=r[2]
            url_dict["{#CODE}"]=r[3]
            web_list.append(url_dict)
    web_dict["data"]=web_list
    jsonStr = json.dumps(web_dict, sort_keys=True, indent=4)
    return jsonStr

#这个函数用于测试站点返回的状态码，注意在cmd命令中如果有%{}这种字符要使用占位符代替，否则
#会报错

def web_site_code():
       #cmd='curl -o /dev/null -s -w %s %s' %("%{http_code}",sys.argv[2])
       cmd='curl -o /dev/null --connect-timeout 3 -m 3 -s -w %s -H "Host: %s" "%s"' %("%{http_code}", sys.argv[2], sys.argv[3])
       reply_code=os.popen(cmd).readlines()[0]
       return reply_code

if __name__ == "__main__":
  try:
    if sys.argv[1] == "web_site_discovery":
        print web_site_discovery()
    elif sys.argv[1] == "web_site_code":
        print web_site_code()
    else:
        print "Pls sys.argv[0] web_site_discovery | web_site_code [sitename] [ip] "
  except Exception as msg:
        print msg
#这里对脚本传递进来的第一个参数做判断去执行不同的函数，为什么要这样，因为通过一个脚本写了两个功能
