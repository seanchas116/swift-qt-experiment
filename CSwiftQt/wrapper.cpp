#include <QApplication>
#include <QWidget>
#include <QLabel>
#include "wrapper.h"

extern "C" {

void QObject_delete(void *self) {
    delete static_cast<QObject *>(self);
}

void *QApplication_new(int argc, char **argv) {
    return new QApplication(argc, argv);
}

void *QLabel_new(StringReference text) {
    return new QLabel(QString::fromUtf16(text.data, text.size));
}

void QWidget_show(void *widget) {
    static_cast<QWidget *>(widget)->show();
}

}
