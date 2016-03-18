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

int QApplication_exec(void *app) {
  return static_cast<QApplication *>(app)->exec();
}

void QWidget_show(void *widget) {
    static_cast<QWidget *>(widget)->show();
}

void *QLabel_new(void *text) {
    return new QLabel(*static_cast<QString *>(text));
}

void *QString_new(int len, uint16_t *buf) {
    auto str = QString::fromUtf16(buf, len);
    return new QString(str);
}

void QString_delete(void *str) {
    delete static_cast<QString *>(str);
}

}
