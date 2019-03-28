#!/usr/bin/env bash
# root path
# this script is for centos
BUILD_ROOT=$(dirname $(readlink -f $0))

yum install -y wget curl git subversion make cmake autoconf automake zlib-devel bzip2-devel pcre pcre-devel libxml2 libxml2-devel libxslt-devel openssl-devel gd gd-devel libjpeg-turbo libjpeg-turbo-devel libpng libpng-devel freetype freetype-devel libtiff libtiff-devel libvpx libvpx-devel\
    ncurses-devel sqlite-devel readline readline-devel tk-devel tcl-devel gdbm-devel xz-devel expat-devel
# need to install mysql by hand and configure something

CODE_BUILD_PATH=$BUILD_ROOT/resty_build
#mkdir -p $CODE_BUILD_PATH
cd $CODE_BUILD_PATH

wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
git clone https://github.com/slact/nchan.git nchan
git clone https://github.com/arut/nginx-rtmp-module.git nginx-rtmp-module
git clone https://github.com/leev/ngx_http_geoip2_module.git ngx_http_geoip2_module
git clone --recursive https://github.com/maxmind/libmaxminddb libmaxminddb

MAXMIND_PATH=$CODE_BUILD_PATH/libmaxminddb
cd $MAXMIND_PATH
./bootstrap
./configure
make
make install
sh -c "echo /usr/local/lib  >> /etc/ld.so.conf.d/local.conf"
ldconfig

tar -zxvf openresty-1.13.6.2.tar.gz

RESTY_PATH=$CODE_BUILD_PATH/openresty-1.13.6.2

cd $RESTY_PATH

./configure --prefix='/usr/local/openresty-1.13.6.2' -j4 \
            --with-http_iconv_module \
            --build='openresty-1.13.6.2 NuoNuo Tech' \
            --with-threads \
            --with-file-aio \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_xslt_module=dynamic \
            --with-http_image_filter_module=dynamic \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_sub_module \
            --with-http_gzip_static_module \
            --with-http_auth_request_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_slice_module \
            --with-http_stub_status_module \
            --with-http_perl_module=dynamic \
            --with-stream=dynamic \
            --with-stream_ssl_module \
            --with-stream_realip_module \
            --with-stream_ssl_preread_module \
            --add-dynamic-module=$CODE_BUILD_PATH'/nchan' \
            --add-dynamic-module=$CODE_BUILD_PATH'/nginx-rtmp-module' \
            --add-dynamic-module=$CODE_BUILD_PATH'/ngx_http_geoip2_module'
gmake
gmake install
ln -s /usr/local/openresty-1.13.6.2/nginx/sbin/nginx /usr/sbin/nginx
