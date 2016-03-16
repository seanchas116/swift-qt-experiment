#-------------------------------------------------
#
# Project created by QtCreator 2016-03-16T19:11:16
#
#-------------------------------------------------

QT       += widgets

TARGET = SwiftQtCWrapper
TEMPLATE = lib
CONFIG += c++11

DEFINES += SWIFTQTCWRAPPER_LIBRARY

SOURCES += \
    wrapper.cpp

HEADERS += \
    wrapper.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
