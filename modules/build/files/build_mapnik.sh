#!/bin/bash

PATH='/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin'

start_date="$(date +%s)"
target="/opt/mapnik-${start_date}"

mkdir ${target}

cd /opt/mapnik-2.0.0
python scons/scons.py configure PREFIX=${target} PYTHON_PREFIX=${target}
python scons/scons.py
python scons/scons.py install

cd /opt/mapnik-rpms

fpm -s dir -n mapnik -v 2.0.0 --iteration "${start_date}" \
    -C "${target}" -t rpm --prefix /usr --url http://mapnik.org/ \
    --description "Mapnik is a Free Toolkit for developing mapping applications." \
    --exclude include

fpm -s dir -n mapnik-devel -v 2.0.0 --iteration "${start_date}" \
    -C "${target}/include" -t rpm --prefix /usr/include --url http://mapnik.org/ \
    --description "The mapnik-devel package contains header files for developing programs using the Mapnik library." \
    --depends "mapnik = 2.0.0-${start_date}"

