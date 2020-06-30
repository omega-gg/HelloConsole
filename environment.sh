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

replace()
{
    expression='s/'"$1"'=\"'"$2"'"/'"$1"'=\"'"$3"'"/g'

    case `uname` in
    Darwin*) os="macOS";;
    *)       os="other";;
    esac

    if [ $os = "macOS" ]; then

        sed -i "" $expression environment.sh

        sed -i "" $expression 3rdparty.sh
        sed -i "" $expression configure.sh
        sed -i "" $expression build.sh
        sed -i "" $expression deploy.sh
    else
        sed -i $expression environment.sh

        sed -i $expression 3rdparty.sh
        sed -i $expression configure.sh
        sed -i $expression build.sh
        sed -i $expression deploy.sh
    fi
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
