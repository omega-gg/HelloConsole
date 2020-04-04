#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 ] || [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] || [ $2 != "win32" -a \
                                                                       $2 != "win64" -a \
                                                                       $2 != "macOS" -a \
                                                                       $2 != "linux" -a \
                                                                       $2 != "android" ]; then

    echo "Usage: deploy <qt4 | qt5 | clean> <win32 | win64 | macOS | linux | android>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

if [ $2 = "win32" -o $2 = "win64" ]; then

    os="windows"
else
    os="default"
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

    cp "$path"/libgcc_s_*-1.dll    deploy
    cp "$path"/libstdc++-6.dll     deploy
    cp "$path"/libwinpthread-1.dll deploy

    if [ $1 = "qt4" ]; then

        cp "$path"/QtCore4.dll        deploy
        cp "$path"/QtNetwork4.dll     deploy
        cp "$path"/QtScript4.dll      deploy
        cp "$path"/QtXml4.dll         deploy
        cp "$path"/QtXmlPatterns4.dll deploy
    else
        cp "$path"/Qt5Core.dll        deploy
        cp "$path"/Qt5Network.dll     deploy
        cp "$path"/Qt5Qml.dll         deploy
        cp "$path"/Qt5Xml.dll         deploy
        cp "$path"/Qt5XmlPatterns.dll deploy
    fi

elif [ $2 = "macOS" ]; then

    cp "$path"/*.dylib deploy

    rm -f deploy/Sk*.dylib

elif [ $2 = "linux" ]; then

    cp "$path"/*.so* deploy

    rm -f deploy/Sk*.so*
fi

#--------------------------------------------------------------------------------------------------
# HelloConsole
#--------------------------------------------------------------------------------------------------

echo "COPYING HelloConsole"

if [ $2 = "macOS" ]; then

    cp bin/HelloConsole deploy

    cd deploy

    #----------------------------------------------------------------------------------------------
    # Qt

    install_name_tool -change @rpath/QtCore.framework/Versions/5/QtCore \
                              @loader_path/QtCore.dylib HelloConsole

    install_name_tool -change @rpath/QtGui.framework/Versions/5/QtGui \
                              @loader_path/QtGui.dylib HelloConsole

    install_name_tool -change @rpath/QtNetwork.framework/Versions/5/QtNetwork \
                              @loader_path/QtNetwork.dylib HelloConsole

    install_name_tool -change @rpath/QtOpenGL.framework/Versions/5/QtOpenGL \
                              @loader_path/QtOpenGL.dylib HelloConsole

    install_name_tool -change @rpath/QtQml.framework/Versions/5/QtQml \
                              @loader_path/QtQml.dylib HelloConsole

    install_name_tool -change @rpath/QtQuick.framework/Versions/5/QtQuick \
                              @loader_path/QtQuick.dylib HelloConsole

    install_name_tool -change @rpath/QtSvg.framework/Versions/5/QtSvg \
                              @loader_path/QtSvg.dylib HelloConsole

    install_name_tool -change @rpath/QtWidgets.framework/Versions/5/QtWidgets \
                              @loader_path/QtWidgets.dylib HelloConsole

    install_name_tool -change @rpath/QtXml.framework/Versions/5/QtXml \
                              @loader_path/QtXml.dylib HelloConsole

    install_name_tool -change @rpath/QtXmlPatterns.framework/Versions/5/QtXmlPatterns \
                              @loader_path/QtXmlPatterns.dylib HelloConsole
    cd -

elif [ $2 = "android" ]; then

    cp bin/libHelloConsole* deploy
else
    cp bin/HelloConsole* deploy
fi
