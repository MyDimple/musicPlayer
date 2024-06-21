import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    Layout.fillWidth: true
    height: 60

    RowLayout{
        anchors.fill: parent

        Item{
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth: true
        }

        Item{
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 30

            Text{
                id:_nameText
                anchors.left: _slider.left
                anchors.bottom: _slider.top
                anchors.leftMargin: 2
                text:"歌名-歌手"
            }

            Text{
                id:_timeText
                anchors.right: _slider.right
                anchors.bottom: _slider.top
                anchors.rightMargin: 2
                text:"00:00/05:30"
            }

            //进度条
            Slider{
                id:_slider
                width:parent.width
                Layout.fillWidth: true
                height:25
                background: Rectangle{
                    x:_slider.leftPadding
                    y:_slider.topPadding + (_slider.availableHeight-height)/2
                    width:_slider.availableWidth
                    height:4
                    radius: 2
                    color: "#e9f4ff"
                    Rectangle{//实现拖动颜色变化
                        width: _slider.visualPosition*parent.width
                        height: parent.height
                        color:"grey"
                        radius: 2
                    }
                }

                handle:Rectangle{
                    x:_slider.topPadding + (_slider.availableWidth-width)*_slider.visualPosition //拖动效果
                    y:_slider.topPadding + (_slider.availableHeight-height)/2
                    width: 15
                    height: 15
                    radius: 5
                    color: "#f0f0f0"
                    border.color: "#73a7ab"
                    border.width: 0.5
                }
            }
        }

        Item{
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth: true
        }

    }
}

