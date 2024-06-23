#include "search.h"
// #include <QNetworkAccessManager>
// #include <QNetworkReply>
Search::Search(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager(this);
    // connect(manager, SIGNAL(finished(QNetworkReply *)), this, SLOT(replyFinished(QNetworkReply *)));
    connect(manager, &QNetworkAccessManager::finished, this, &Search::replyFinished);
}

void Search::replyFinished(QNetworkReply *reply)
{
    // qDebug() << "Network request failed: ";
    if (reply->error() != QNetworkReply::NoError) {
        // 请求发生错误
        qDebug() << "Network request failed: " << reply->errorString();
        return;
    }
    emit replySignal(reply->readAll()); //返回的是字符串,发送信号由qml监听
}

void Search::concatenate(QString url)
{
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + url)); //拼接成完整的链接,设置请求的URL

    manager->get(request);
}
