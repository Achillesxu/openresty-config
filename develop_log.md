# openresty工程, nginx相关的配置
记录人：achilles_xushy

## 2017-12-21 openresty-1.13.6.1 build working dir
    openresty-1.13.6.1
    |---conf  nginx配置路径
    |---services 运行在服务器里面的lua代码
        |---conf 服务程序的配置路径
        |---resty_modules 服务程序使用的lua-resty库， lua库
        |---http  http服务程序 and static file
        |---stream TCP／UDP服务程序
        |---utils 通用工具程序
    1. 编写nginx配置文件
    
## 2018-01-16 openresty-1.13.6.1 
    1. 编写openresty的自动编译脚本
    2. 安装编译必备的库
    3. download GeoLite2
        wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
        wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz
    4. 安装的libmaxminddb, 需要在/usr/local/目录下能找到
    5. 配置geoip2 用于查询ip相关的信息
    
## 2018-02-01 openresty-1.13.6.1
    1. 添加方向代理到后端down-7po-com， achilles-django， achilles-flask
    2. 添加down.7po.com相关网站的入口
    3. 添加achilles-lua.com, achilles-django.com, achilles-flask.com入口
    4. 调整nginx工作路径的结构
    5. 添加mac的openresty的编译文件mac_config.sh
    6. 调整openresty_conf.sh编译选项
 
## 2018-02-02 openresty-1.13.6.1
    1. 调整nginx.conf配置文件，添加flask反向代理入口
    2. 调整nginx的mac配置文件，通过编译
    3. 调整down_7po_com相关的路径

## 2018-02-26 openresty-1.13.6.1  
    1. 添加lua接口查询ssdb的hash结构所有内容 
    2. 调整nginx打开的最大连接数
    3. 增加lua代码访问hash的key记录
    
## 2018-10-06 openresty-1.13.6.2
    1. 更新openresty版本
    2. 添加   
    