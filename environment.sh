#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

#--------------------------------------------------------------------------------------------------

compiler_win="mingw"

qt="qt5"

#--------------------------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------------------------

replaceAll()
{
    expression='s/'"$1"'=\"'"$2"'"/'"$1"'=\"'"$3"'"/g'

    replace $expression environment.sh

    replace $expression 3rdparty.sh
    replace $expression configure.sh
    replace $expression build.sh
    replace $expression deploy.sh
}

replace()
{
    if [ $host = "macOS" ]; then

        sed -i "" $1 $2
    else
        sed -i $1 $2
    fi
}

#--------------------------------------------------------------------------------------------------

getOs()
{
    case `uname` in
    Darwin*) echo "macOS";;
    *)       echo "other";;
    esac
}

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 -a $# != 3 ] \
   || \
   [ $1 != "gcc" -a $1 != "mingw" -a $1 != "msvc" ] || [ $2 != "qt4" -a $2 != "qt5" ] \
   || \
   [ $# = 3 -a "$3" != "all" ]; then

    echo "Usage: environment <gcc | mingw | msvc> <qt4 | qt5> [all]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

host=$(getOs)

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

if [ "$3" = "all" ]; then

    echo "ENVIRONMENT Sky"
    echo "---------------"

    cd "$Sky"

    sh environment.sh $1 $2

    cd -

    echo "---------------"
    echo ""
fi

#--------------------------------------------------------------------------------------------------
# Replacements
#--------------------------------------------------------------------------------------------------

if [ $1 = "msvc" ]; then

    replace compiler_win $compiler_win msvc
else
    replace compiler_win $compiler_win mingw
fi

replace qt $qt $2
