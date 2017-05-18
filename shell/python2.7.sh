#!/usr/bin/env bash
#安装依赖
yum groupinstall -y development
yum install -y readline-devel zlib-devel openssl-devel sqlite-devel bzip2-devel ncurses-devel

#下载源码
wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar -zxvf Python-2.7.13.tgz
cd Python-2.7.13
mkdir /usr/local/python2.7.13
./configure --prefix=/usr/local/python2.7.13
make
make install
if [ $? -eq 0 ];then
     echo "Python2.7.13升级完成"
else
     echo "Python2.7.13升级失败，查看报错信息手动安装"
fi	


#备份旧版本python
cd
mv /usr/bin/python /usr/bin/python2.6
ln -s /usr/local/python2.7.13/bin/python2.7 /usr/bin/python
sed -i '1s/python/python2.6/g' /usr/bin/yum

#安装pip
#wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

if [ $? -eq 0 ];then
     echo "pip升级完成"
else
     echo "pip安装失败，查看报错信息手动安装"
fi

rm -rf /usr/bin/pip
ln -s /usr/local/python2.7.13/bin/pip2.7 /usr/bin/pip

#修改pip镜像源
cd
mkdir /root/.pip/ && cd .pip
cat > pip.conf <<EOF
[global]
timeout = 6000
trusted-host =  mirrors.aliyun.com
index-url = https://mirrors.aliyun.com/pypi/simple/

[list]
format=columns
EOF