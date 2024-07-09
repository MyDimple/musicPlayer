import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "freems.js" as Control

ToolBar{//顶部工具栏
    property point point: Qt.point(x,y)
     property bool isSmallWindow: false
    background: Rectangle{
        color: "grey"
        }
    width: parent.width
    Layout.fillWidth: true
    RowLayout{
        anchors.fill:parent

        MusicToolButton{
            iconSource: "qrc:/icons/guanyu.png"
            toolTip: "关于"

        }
        MusicToolButton{
            iconSource: "qrc:/icons/yinle.png"
            toolTip: "官网"
        }
        MusicToolButton{
            id:smallWindow
            iconSource: "qrc:/icons/xiaochuangbofang.png"
            toolTip: "小窗播放"
            visible: !isSmallWindow
            onClicked: {
                isSmallWindow = true
                Control.setWindowSize(400,600)
                pageHomeView.visible = false
                pageDetailView.visible = true
                // appBackground.showDefaultBackground =  pageHomeView.visible
            }
        }

        MusicToolButton{
            id:normalWindow
            iconSource: "qrc:/icons/tuichuxiaochuang.png"
            toolTip: "退出小窗播放"
            visible: isSmallWindow
            onClicked: {
                Control.setWindowSize()
                isSmallWindow = false
                // appBackground.showDefaultBackground =  pageHomeView.visiblez
            }
        }
        Item{
            visible:! _layoutHeaderView.isSmallWindow
            Layout.fillWidth: true
            Layout.fillHeight: true
            height: 32

            Text{
                anchors.centerIn: parent
                text:qsTr("free music player")
                font.family: "微软雅黑"
                font.pointSize: 15
                color:"#ffffff"
                    }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed:  Control.setPoint(mouseX,mouseY)
                onMouseXChanged: Control.moveX(mouseX)
                onMouseYChanged: Control.moveY(mouseY)
                onClicked: {
                console.log("clic....")}
            }

            }
        MusicToolButton{
            iconSource: "qrc:/icons/zuixiaohua.png"
            toolTip: "最小化"
            onClicked: {
                           window.hide()
                       }
        }

        MusicToolButton{
                    id:resize
                    icon.source: "qrc:/icons/suoxiao.png"
                    toolTip: "退出全屏"
                    visible: false
                    onClicked: {
                        Control.setWindowSize()
                        window.visibility = Window.AutomaticVisibility
                        maxWindow.visible = true
                        resize.visible = false
                    }
                }

        MusicToolButton{
                    id:maxWindow
                    icon.source: "qrc:/icons/fangda.png"
                    toolTip: "全屏"
                    onClicked: {
                        window.visibility = Window.Maximized
                        maxWindow.visible = false
                        resize.visible = true
                    }
                }

        MusicToolButton{
                   icon.source: "qrc:/icons/guanbi.png"
                   toolTip: "退出"
                   onClicked: {
                       Qt.quit()
                   }
               }
    }


}
