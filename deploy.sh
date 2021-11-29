#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

target="HelloConsole"

Sky="../Sky"

#--------------------------------------------------------------------------------------------------
# environment

compiler_win="mingw"

qt="qt5"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 1 -a $# != 2 ] \
   || \
   [ $1 != "win32" -a $1 != "win64" -a $1 != "macOS" -a $1 != "linux" -a $1 != "android" ] \
   || \
   [ $# = 2 -a "$2" != "clean" ]; then

    echo "Usage: deploy <win32 | win64 | macOS | linux | android> [clean]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

if [ $1 = "win32" -o $1 = "win64" ]; then

    os="windows"

    compiler="$compiler_win"
else
    os="default"

    compiler="default"
fi

if [ $qt = "qt5" ]; then

    QtX="Qt5"

    qx="5"

elif [ $qt = "qt6" ]; then

    QtX="Qt6"

    qx="6"
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf deploy/*

touch deploy/.gitignore

if [ "$2" = "clean" ]; then

    exit 0
fi

echo ""

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

echo "DEPLOYING Sky"
echo "-------------"

cd "$Sky"

sh deploy.sh $1 tools

cd -

path="$Sky/deploy"

if [ $os = "windows" ]; then

    if [ $compiler = "mingw" ]; then

        cp "$path"/libgcc_s_*-1.dll    deploy
        cp "$path"/libstdc++-6.dll     deploy
        cp "$path"/libwinpthread-1.dll deploy
    fi

    if [ $qt = "qt4" ]; then

        cp "$path"/QtCore4.dll        deploy
        cp "$path"/QtNetwork4.dll     deploy
        cp "$path"/QtScript4.dll      deploy
        cp "$path"/QtXml4.dll         deploy
        cp "$path"/QtXmlPatterns4.dll deploy
    else
        cp "$path"/"$QtX"Core.dll    deploy
        cp "$path"/"$QtX"Network.dll deploy
        cp "$path"/"$QtX"Xml.dll     deploy

        if [ $qt = "qt5" ]; then

            cp "$path"/"$QtX"XmlPatterns.dll deploy
        else
            cp "$path"/"$QtX"Core5Compat.dll deploy
        fi
    fi

elif [ $1 = "macOS" ]; then

    if [ $qt != "qt4" ]; then

        # FIXME Qt 5.14 macOS: We have to copy qt.conf to avoid a segfault.
        cp "$path"/qt.conf deploy

        cp "$path"/QtCore.dylib    deploy
        cp "$path"/QtNetwork.dylib deploy
        cp "$path"/QtXml.dylib     deploy

        if [ $qt = "qt5" ]; then

            cp "$path"/QtXmlPatterns.dylib deploy
        else
            cp "$path"/QtCore5Compat.dylib deploy
        fi
    fi

elif [ $1 = "linux" ]; then

    if [ $qt = "qt4" ]; then

        cp "$path"/libQtCore.so.4        deploy
        cp "$path"/libQtNetwork.so.4     deploy
        cp "$path"/libQtScript.so.4      deploy
        cp "$path"/libQtXml.so.4         deploy
        cp "$path"/libQtXmlPatterns.so.4 deploy
    else
        cp "$path"/lib"$QtX"Core.so.5    deploy
        cp "$path"/lib"$QtX"Network.so.5 deploy
        cp "$path"/lib"$QtX"Xml.so.5     deploy

        if [ $qt = "qt5" ]; then

            cp "$path"/lib"$QtX"XmlPatterns.so.$qx deploy
        else
            cp "$path"/lib"$QtX"Core5Compat.so.$qx deploy
        fi
    fi

elif [ $1 = "android" ]; then

    if [ $qt != "qt4" ]; then

        cp "$path"/lib"$QtX"Core_*.so    deploy
        cp "$path"/lib"$QtX"Network_*.so deploy
        cp "$path"/lib"$QtX"Xml_*.so     deploy

        if [ $qt = "qt5" ]; then

            cp "$path"/lib"$QtX"XmlPatterns_*.so deploy
        else
            cp "$path"/lib"$QtX"Core5Compat_*.so deploy
        fi
    fi
fi

echo "-------------"
echo ""

#--------------------------------------------------------------------------------------------------
# HelloConsole
#--------------------------------------------------------------------------------------------------

echo "COPYING $target"

if [ $os = "windows" ]; then

    cp bin/$target.exe deploy

elif [ $1 = "macOS" ]; then

    cp bin/$target deploy

    cd deploy

    #----------------------------------------------------------------------------------------------
    # Qt

    install_name_tool -change @rpath/QtCore.framework/Versions/5/QtCore \
                              @loader_path/QtCore.dylib $target

    install_name_tool -change @rpath/QtNetwork.framework/Versions/5/QtNetwork \
                              @loader_path/QtNetwork.dylib $target

    install_name_tool -change @rpath/QtQml.framework/Versions/5/QtQml \
                              @loader_path/QtQml.dylib $target

    install_name_tool -change @rpath/QtXml.framework/Versions/5/QtXml \
                              @loader_path/QtXml.dylib $target

    install_name_tool -change @rpath/QtXmlPatterns.framework/Versions/5/QtXmlPatterns \
                              @loader_path/QtXmlPatterns.dylib $target

    #----------------------------------------------------------------------------------------------

    cd -

elif [ $1 = "linux" ]; then

    cp bin/$target deploy

elif [ $1 = "android" ]; then

    cp bin/lib$target* deploy
fi
