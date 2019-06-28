#!/usr/bin/env bash
# root path
# this script is for ubuntu or debian
BUILD_ROOT=$(dirname $(readlink -f $0))

#========================================================================
# input options
#------------------------------------------------------------------------

CODE_BUILD_PATH=$BUILD_ROOT/resty_build
mkdir -p $CODE_BUILD_PATH
cd $CODE_BUILD_PATH

#wget https://openresty.org/download/openresty-1.15.8.1.tar.gz
#git clone https://github.com/arut/nginx-rtmp-module.git
#git clone https://github.com/slact/nchan.git
#git clone https://github.com/leev/ngx_http_geoip2_module.git
#git clone --recursive https://github.com/maxmind/libmaxminddb

# please confirm all dependant lib already exist
#apt-get install -y make cmake autoconf libtool automake build-essential libpcre3 libpcre3-dev \
#    openssl libssl-dev zlib1g-dev zlib1g perl curl \
#    libxslt1-dev libxml2-dev libgd-dev libgd3 libreadline7 libreadline-dev
# need to install mysql by hand and configure something

#MAXMIND_PATH=$CODE_BUILD_PATH/libmaxminddb
#
#cd $MAXMIND_PATH
#./bootstrap
#./configure
#make
#sudo make install
#
#sudo ldconfig

cd $CODE_BUILD_PATH

tar -zxvf openresty-1.15.8.1.tar.gz

RESTY_PATH=$CODE_BUILD_PATH/openresty-1.15.8.1

cd $RESTY_PATH

./configure --prefix='/usr/local/openresty-1.15.8.1' -j4 \
            --with-http_iconv_module \
            --build='openresty-1.15.8.1 xushiyin' \
            --with-threads \
            --with-file-aio \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_xslt_module=dynamic \
            --with-http_image_filter_module=dynamic \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gzip_static_module \
            --with-http_auth_request_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_slice_module \
            --with-http_stub_status_module \
            --with-http_perl_module=dynamic \
            --with-mail=dynamic \
            --with-mail_ssl_module \
            --with-stream=dynamic \
            --with-stream_ssl_module \
            --add-dynamic-module=$CODE_BUILD_PATH'/nginx-rtmp-module' \
            --add-dynamic-module=$CODE_BUILD_PATH'/nchan' \
            --add-dynamic-module=$CODE_BUILD_PATH'/ngx_http_geoip2_module'
make
sudo make install
ln -s /usr/local/openresty-1.15.8.1/nginx/sbin/nginx /usr/sbin/nginx
