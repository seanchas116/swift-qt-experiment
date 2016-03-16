#pragma once

#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

struct StringReference {
    uint16_t *data;
    size_t size;
};

void QObject_delete(void *self);

void *QApplication_new(int argc, char **argv);

void *QLabel_new(StringReference text);

void QWidget_show(void *widget);

#ifdef __cplusplus
}
#endif
