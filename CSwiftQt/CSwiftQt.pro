#-------------------------------------------------
#
# Project created by QtCreator 2016-03-16T19:11:16
#
#-------------------------------------------------

QT       += widgets

TARGET = CSwiftQt
TEMPLATE = lib
CONFIG += c++11

SOURCES += \
    wrapper.cpp

HEADERS += \
    wrapper.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
