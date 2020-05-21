//=================================================================================================
/*
    Copyright (C) 2015-2020 HelloConsole authors united with omega. <http://omega.gg/about>

    Author: Benjamin Arnaud. <http://bunjee.me> <bunjee@omega.gg>

    This file is part of HelloConsole.

    - GNU General Public License Usage:
    This file may be used under the terms of the GNU General Public License version 3 as published
    by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging
    of this file. Please review the following information to ensure the GNU General Public License
    requirements will be met: https://www.gnu.org/licenses/gpl.html.
*/
//=================================================================================================

// Sk includes
#include <WCoreApplication>

//-------------------------------------------------------------------------------------------------
// Functions
//-------------------------------------------------------------------------------------------------

int main(int argc, char * argv[])
{
    QCoreApplication * application = WCoreApplication::create(argc, argv);

    if (application == NULL) return 0;

    qDebug("Hello Sky Console");

    return application->exec();
}
