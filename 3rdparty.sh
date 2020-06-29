#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

source="https://github.com/omega-gg"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 1 ] \
   || \
   [ $1 != "win32" -a $1 != "win64" -a $1 != "macOS" -a $1 != "linux" -a $1 != "android" ]; then

    echo "Usage: 3rdparty <win32 | win64 | win32-msvc | win64-msvc | macOS | linux | android>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Clone
#--------------------------------------------------------------------------------------------------

cd ..

if [ ! -d "Sky" ]; then

    git clone $source/Sky
fi

#--------------------------------------------------------------------------------------------------
# 3rdparty
#--------------------------------------------------------------------------------------------------

cd Sky

sh 3rdparty.sh $1
