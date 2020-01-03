#!/bin/bash
set -x

cp ${RECIPE_DIR}/libjpeg.pc.in ${SRC_DIR}/.

aclocal
libtoolize --force
automake --add-missing
# not sure why this file gets overwritten, but it is quite important
# to have certain things defined here
autoreconf
# How to do this without a patch???
patch jconfig.cfg ${RECIPE_DIR}/8d_define_cjpeg_djpeg.patch

./configure --prefix=$PREFIX \
            --build=${BUILD}\
            --host=${HOST} \
            --enable-shared=yes \
            --enable-static=yes

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

