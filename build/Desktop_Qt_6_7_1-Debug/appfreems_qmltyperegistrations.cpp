/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <search.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_se_qt_music()
{
    qmlRegisterTypesAndRevisions<Search>("se.qt.music", 1);
    qmlRegisterModule("se.qt.music", 1, 0);
}

static const QQmlModuleRegistration seqtmusicRegistration("se.qt.music", qml_register_types_se_qt_music);
