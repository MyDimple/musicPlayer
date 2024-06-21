#include <QtWidgets/QApplication>
#include "lrc.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Lrc w;
    w.show();
    return a.exec();
}
