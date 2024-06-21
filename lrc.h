#pragma once

#include <QLabel>
#include <QLinearGradient>
#include "ui_lrc.h"

class QTimer;
namespace Ui {
class LrcClass;
}
class Lrc : public QLabel
{
    Q_OBJECT

public:
    Lrc(QWidget *parent = Q_NULLPTR);
    ~Lrc();
    //设置歌词控件长度
    // void setLrcWidth(int w) { m_lrcWidth = w; };

    void setLrcTextFontSize(int size);
    //遮罩开启，参数是当前显示歌词开始到结束时间和歌词文本内容
    void startLrcMask(qint64 intervalTime, const QString &text);

    void stopLrcMask();

private slots:
    void sltTimerOut();

private:
    virtual void paintEvent(QPaintEvent *event);

private:
    Ui::LrcClass ui;

    QLinearGradient m_textLinearGradient;

    QLinearGradient m_maskLinearGradient;

    int m_lrcMaskWidth;

    int m_lrcMaskWidthInterval;

    int m_lrcWidth;

    QFont m_font;

    QTimer *m_timer = Q_NULLPTR;
};
