#pragma once


#ifdef __cplusplus
#include <cstdint>
extern "C" {
#else
#include <stdint.h>
#endif

void QObject_delete(void *self);

void *QApplication_new(int argc, char **argv);
int QApplication_exec(void *app);

void QWidget_show(void *widget);

void *QLabel_new(void *text);

void *QString_new(int len, uint16_t *buf);
void QString_delete(void *str);

#ifdef __cplusplus
}
#endif
