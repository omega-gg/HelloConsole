#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

external="../3rdparty"

#--------------------------------------------------------------------------------------------------

MinGW_version="7.3.0"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 -a $# != 3 ] \
   || \
   [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] \
   || \
   [ $2 != "win32" -a $2 != "win64" -a $2 != "macOS" -a $2 != "linux" -a $2 != "android" ] \
   || \
   [ $# = 3 -a "$3" != "sky" ]; then

    echo "Usage: configure <qt4 | qt5 | clean>"
    echo "                 <win32 | win64 | macOS | linux | android>"
    echo "                 [sky]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

external="$external/$2"

if [ $2 = "win32" -o $2 = "win64" ]; then

    os="windows"

    MinGW="$external/MinGW/$MinGW_version/bin"
else
    os="default"
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf bin/*

touch bin/.gitignore

rm -rf build/*

touch build/.gitignore

if [ $1 = "clean" ]; then

    exit 0
fi

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

if [ "$3" = "sky" ]; then

    echo "CONFIGURING Sky"
    echo "---------------"

    cd "$Sky"

    sh configure.sh $1 $2

    cd -

    echo "---------------"
    echo ""
fi

#--------------------------------------------------------------------------------------------------
# MinGW
#--------------------------------------------------------------------------------------------------

echo "CONFIGURING HelloConsole"

if [ $os = "windows" ]; then

    cp "$MinGW"/libgcc_s_*-1.dll    bin
    cp "$MinGW"/libstdc++-6.dll     bin
    cp "$MinGW"/libwinpthread-1.dll bin
fi
