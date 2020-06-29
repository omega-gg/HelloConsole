HelloConsole
---
[![azure](https://dev.azure.com/bunjee/HelloConsole/_apis/build/status/omega-gg.HelloConsole)](https://dev.azure.com/bunjee/HelloConsole/_build)
[![GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl.html)

HelloConsole is a "Hello World" console application built with Sky kit.<br>

## Technology

HelloConsole is built in C++ with [Sky kit](http://omega.gg/Sky/sources).<br>

## Platforms

- Windows XP and later.
- macOS 64 bit.
- Linux 32 bit and 64 bit.
- Android 32 bit and 64 bit.

## Requirements

- [Sky](http://omega.gg/Sky/sources) latest version.
- [Qt](http://download.qt.io/official_releases/qt) 4.8.0 / 5.5.0 or later.

On Windows:
- [MinGW](http://sourceforge.net/projects/mingw) or [Git for Windows](http://git-for-windows.github.io) with g++ 4.9.2 or later.

Recommended:
- [Qt Creator](http://download.qt.io/official_releases/qtcreator) 3.6.0 or later.

## 3rdparty

You can install third party libraries with:

    sh 3rdparty.sh <win32 | win64 | macOS | linux | android>

## Configure

You can configure HelloConsole with:

    sh configure.sh <win32 | win64 | macOS | linux | android> [sky]

## Build

You can build HelloConsole with:

    sh build.sh <win32 | win64 | macOS | linux | android> [deploy | clean]

## Deploy

You can deploy HelloConsole with:

    sh deploy.sh <win32 | win64 | macOS | linux | android> [clean]

## License

Copyright (C) 2015 - 2020 HelloConsole authors | http://omega.gg/HelloConsole.

### Authors

- Benjamin Arnaud aka [bunjee](http://bunjee.me) | <bunjee@omega.gg>

### GNU General Public License Usage

HelloConsole may be used under the terms of the GNU General Public License version 3 as published
by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging
of this file. Please review the following information to ensure the GNU General Public License
requirements will be met: https://www.gnu.org/licenses/gpl.html.

### Private License Usage

HelloConsole licensees holding valid private licenses may use this file in accordance with the
private license agreement provided with the Software or, alternatively, in accordance with the
terms contained in written agreement between you and HelloConsole authors. For further information
contact us at contact@omega.gg.
