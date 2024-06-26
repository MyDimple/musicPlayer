import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

ToolBar{//顶部工具栏
    background: Rectangle{
        color:"#00000000"
        }
    width: parent.width
    Layout.fillWidth: true
    RowLayout{
        anchors.fill:parent
        Item{
            Layout.fillWidth: true
            height: 32
            Text{
                anchors.centerIn: parent
                text:qsTr("welcome to freemusic")
                font.family: "微软雅黑"
                font.pointSize: 15
                color:"#ffffff"
                    }
        }
        MusicToolButton{
            iconSource: "qrc:/images/music"
            toolTip: "关于"
        }
        MusicToolButton{
            iconSource: "qrc:/images/about"
            toolTip: "官网"
        }
        MusicToolButton{
            iconSource: "qrc:/images/small-window"
            toolTip: "小窗"
        }


        MusicToolButton{
            iconSource: "qrc:/images/minimize-screen"
            toolTip: "最小化"
        }

        MusicToolButton{
            iconSource: "qrc:/images/full-screen"
            toolTip: "全屏播放"
        }

        MusicToolButton{
            iconSource: "qrc:/images/power"
            toolTip: "退出"
        }


    }
}
