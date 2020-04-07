SK = $$_PRO_FILE_PWD_/../Sky

SK_CORE = $$SK/src/SkCore/src

TARGET = HelloConsole

DESTDIR = $$_PRO_FILE_PWD_/bin

contains(QT_MAJOR_VERSION, 4) {
    QT += network script xml xmlpatterns
} else {
    QT += network xml xmlpatterns
}

QT -= gui

CONFIG += console

macx:CONFIG -= app_bundle

DEFINES += SK_CONSOLE SK_NO_QML SK_CORE_LIBRARY

contains(QT_MAJOR_VERSION, 4) {
    DEFINES += QT_4
} else {
    DEFINES += QT_LATEST
}

QMAKE_CXXFLAGS += -std=c++11

unix:QMAKE_LFLAGS += "-Wl,-rpath,'\$$ORIGIN'"

include(src/global/global.pri)
include(src/controllers/controllers.pri)
include(src/kernel/kernel.pri)
include(src/io/io.pri)
include(src/thread/thread.pri)

include(src/3rdparty/qtsingleapplication/qtsingleapplication.pri)

INCLUDEPATH += $$SK/include/SkCore \

OTHER_FILES += 3rdparty.sh \
               configure.sh \
               build.sh \
               deploy.sh \
               README.md \
               LICENSE.md \
               AUTHORS.md \
               .azure-pipelines.yml \
