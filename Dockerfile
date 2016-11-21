FROM gliderlabs/alpine:3.1
MAINTAINER Oliver Soell <oliver@soell.net>

RUN apk-install collectd collectd-curl collectd-rrdtool collectd-nginx collectd-write_http collectd-network py-pip btrfs-progs

RUN pip install envtpl
ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl
ADD collectd.d /etc/collectd/collectd.d
ADD btrfs-data.py /usr/local/bin/btrfs-data.py
CMD sleep 10; for template in /etc/collectd/collectd.conf.tpl ; do envtpl $template ; done && exec collectd -f
