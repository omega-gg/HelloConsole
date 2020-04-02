SK = $$_PRO_FILE_PWD_/../Sky

SK_CORE = $$SK/src/SkCore/src

TARGET = HelloConsole

DESTDIR = $$_PRO_FILE_PWD_/bin

DEFINES += SK_CORE_LIBRARY

contains(QT_MAJOR_VERSION, 4) {
    DEFINES += QT_4
} else {
    DEFINES += QT_LATEST
}

QMAKE_CXXFLAGS += -std=c++11

unix:QMAKE_LFLAGS += "-Wl,-rpath,'\$$ORIGIN'"

include(src/global/global.pri)

INCLUDEPATH += $$SK/include/SkCore \

OTHER_FILES += README.md \
               LICENSE.md \
               AUTHORS.md \
               .azure-pipelines.yml \
