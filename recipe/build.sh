#!/bin/bash
set -x

cp ${RECIPE_DIR}/libjpeg.pc.in ${SRC_DIR}/.

aclocal
libtoolize --force
automake --add-missing
autoreconf

./configure --prefix=$PREFIX \
            --build=${BUILD}\
            --host=${HOST} \
            --enable-shared=yes \
            --enable-static=yes

make -j${CPU_COUNT} ${VERBOSE_AT}
# make check
make install

