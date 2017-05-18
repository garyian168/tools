#!/usr/bin/env bash
#安装依赖
yum install -y readline-devel zlib-devel

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
mv /usr/bin/python /usr/bin/python2.6.6
ln -s /usr/local/python2.7.13/bin/python2.7 /usr/bin/python
sed -i '1s/python/python2.6/g' /usr/bin/yum

#安装pip
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

if [ $? -eq 0 ];then
     echo "pip升级完成"
else
     echo "pip安装失败，查看报错信息手动安装"
fi

rm -rf /usr/bin/pip
ln -s /usr/local/python2.7.13/bin/pip2.7 /usr/bin/pip