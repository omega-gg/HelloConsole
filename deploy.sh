#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 ] || [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] \
   || \
   [ $2 != "win32" -a $2 != "win64" -a $2 != "win32-msvc" -a $2 != "win64-msvc" -a \
     $2 != "macOS" -a $2 != "linux" -a $2 != "android" ]; then

    echo "Usage: deploy <qt4 | qt5 | clean>"
    echo "              <win32 | win64 | win32-msvc | win64-msvc | macOS | linux | android>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

if [ $2 = "win32" -o $2 = "win64" -o $2 = "win32-msvc" -o $2 = "win64-msvc" ]; then

    os="windows"

    if [ $2 = "win32" -o $2 = "win64" ]; then

        compiler="mingw"
    else
        compiler="default"
    fi
else
    os="default"

    compiler="default"
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf deploy/*

touch deploy/.gitignore

if [ $1 = "clean" ]; then

    exit 0
fi

echo ""

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

echo "COPYING Sky"

path="$Sky/deploy"

if [ $os = "windows" ]; then

    if [ $compiler = "mingw" ]; then

        cp "$path"/libgcc_s_*-1.dll    deploy
        cp "$path"/libstdc++-6.dll     deploy
        cp "$path"/libwinpthread-1.dll deploy
    fi

    if [ $1 = "qt4" ]; then

        cp "$path"/QtCore4.dll        deploy
        cp "$path"/QtNetwork4.dll     deploy
        cp "$path"/QtScript4.dll      deploy
        cp "$path"/QtXml4.dll         deploy
        cp "$path"/QtXmlPatterns4.dll deploy
    else
        cp "$path"/Qt5Core.dll        deploy
        cp "$path"/Qt5Network.dll     deploy
        cp "$path"/Qt5Xml.dll         deploy
        cp "$path"/Qt5XmlPatterns.dll deploy
    fi

elif [ $2 = "macOS" ]; then

    if [ $1 = "qt5" ]; then

        # FIXME Qt 5.14 macOS: We have to copy qt.conf to avoid a segfault.
        cp "$path"/qt.conf deploy

        cp "$path"/QtCore.dylib        deploy
        cp "$path"/QtNetwork.dylib     deploy
        cp "$path"/QtXml.dylib         deploy
        cp "$path"/QtXmlPatterns.dylib deploy
    fi

elif [ $2 = "linux" ]; then

    if [ $1 = "qt4" ]; then

        cp "$path"/libQtCore.so.4        deploy
        cp "$path"/libQtNetwork.so.4     deploy
        cp "$path"/libQtScript.so.4      deploy
        cp "$path"/libQtXml.so.4         deploy
        cp "$path"/libQtXmlPatterns.so.4 deploy
    else
        cp "$path"/libQt5Core.so.5        deploy
        cp "$path"/libQt5Network.so.5     deploy
        cp "$path"/libQt5Xml.so.5         deploy
        cp "$path"/libQt5XmlPatterns.so.5 deploy
    fi

elif [ $2 = "android" ]; then

    if [ $1 = "qt5" ]; then

        cp "$path"/libQt5Core_*.so        deploy
        cp "$path"/libQt5Network_*.so     deploy
        cp "$path"/libQt5Xml_*.so         deploy
        cp "$path"/libQt5XmlPatterns_*.so deploy
    fi
fi

#--------------------------------------------------------------------------------------------------
# HelloConsole
#--------------------------------------------------------------------------------------------------

echo "COPYING HelloConsole"

if [ $os = "windows" ]; then

    cp bin/HelloConsole.exe deploy

elif [ $2 = "macOS" ]; then

    cp bin/HelloConsole deploy

    cd deploy

    #----------------------------------------------------------------------------------------------
    # Qt

    install_name_tool -change @rpath/QtCore.framework/Versions/5/QtCore \
                              @loader_path/QtCore.dylib HelloConsole

    install_name_tool -change @rpath/QtNetwork.framework/Versions/5/QtNetwork \
                              @loader_path/QtNetwork.dylib HelloConsole

    install_name_tool -change @rpath/QtQml.framework/Versions/5/QtQml \
                              @loader_path/QtQml.dylib HelloConsole

    install_name_tool -change @rpath/QtXml.framework/Versions/5/QtXml \
                              @loader_path/QtXml.dylib HelloConsole

    install_name_tool -change @rpath/QtXmlPatterns.framework/Versions/5/QtXmlPatterns \
                              @loader_path/QtXmlPatterns.dylib HelloConsole

    #----------------------------------------------------------------------------------------------

    cd -

elif [ $2 = "linux" ]; then

    cp bin/HelloConsole deploy

elif [ $2 = "android" ]; then

    cp bin/libHelloConsole* deploy
fi
