#pragma once

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>
class Search : public QObject
{
    Q_OBJECT
    // Q_INVOKABLE;
    QML_ELEMENT

public:
    explicit Search(QObject *parent = nullptr);

    Q_INVOKABLE void replyFinished(QNetworkReply *reply);
    Q_INVOKABLE void concatenate(QString url);
signals:
    void replySignal(QString replay);

private:
    QNetworkAccessManager *manager;
    QString BASE_URL = "http://localhost:3000/api/"; //默认域名
};
