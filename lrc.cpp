#include "lrc.h"
#include <QPainter>
#include <QTimer>
#include "ui_lrc.h"
Lrc::Lrc(QWidget *parent)
    : QLabel(parent)
    , m_lrcWidth(1000)
    , m_lrcMaskWidth(0)
    , m_lrcMaskWidthInterval(0)
{
    ui.setupUi(this);

    setWindowFlags(Qt::Window | Qt::FramelessWindowHint);
    setAttribute(Qt::WA_TranslucentBackground);

    setFixedSize(m_lrcWidth, 60);

    m_font.setFamily("Times New Roman");
    m_font.setBold(true);
    m_font.setPointSize(30);

    m_textLinearGradient.setStart(0, 10);
    m_textLinearGradient.setFinalStop(0, 40);
    m_textLinearGradient.setColorAt(0.1, QColor(14, 179, 255));
    m_textLinearGradient.setColorAt(0.5, QColor(114, 232, 255));
    m_textLinearGradient.setColorAt(0.9, QColor(14, 179, 255));

    m_maskLinearGradient.setStart(0, 10);
    m_maskLinearGradient.setFinalStop(0, 40);
    m_maskLinearGradient.setColorAt(0.1, QColor(222, 54, 4));
    m_maskLinearGradient.setColorAt(0.5, QColor(255, 72, 16));
    m_maskLinearGradient.setColorAt(0.9, QColor(222, 54, 4));

    // 定时器初始化
    m_timer = new QTimer(this);
    if (m_timer) {
        connect(m_timer, &QTimer::timeout, this, &Lrc::sltTimerOut);
    }

    startLrcMask(6000, QStringLiteral("情字何解 怎落笔都不对 而我独缺 你一生的了解"));
}

Lrc::~Lrc() {}

void Lrc::setLrcTextFontSize(int size)
{
    m_font.setPointSize(size);
}

void Lrc::startLrcMask(qint64 intervalTime, const QString &text)
{
    //更换文本内容
    setText(text);

    qreal count = intervalTime / 30;

    m_lrcMaskWidthInterval = m_lrcWidth / count;
    m_lrcMaskWidth = 0;
    if (m_timer) {
        m_timer->start(30);
    }
}

void Lrc::stopLrcMask()
{
    if (m_timer) {
        m_timer->stop();
    }
    m_lrcMaskWidth = 0;
    update();
}

void Lrc::sltTimerOut()
{
    m_lrcMaskWidth += m_lrcMaskWidthInterval;
    update();
}

void Lrc::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);
    painter.setFont(m_font);
    // 先绘制底层文字，作为阴影，这样会使显示效果更加清晰，且更有质感
    painter.setPen(QColor(0, 0, 0, 200));
    painter.drawText(1, 1, m_lrcWidth, 60, Qt::AlignLeft, text());
    // 再在上面绘制渐变文字
    painter.setPen(QPen(m_textLinearGradient, 0));
    painter.drawText(0, 0, m_lrcWidth, 60, Qt::AlignLeft, text());
    // 设置歌词遮罩
    painter.setPen(QPen(m_maskLinearGradient, 0));
    painter.drawText(0, 0, m_lrcMaskWidth, 60, Qt::AlignLeft, text());
}
