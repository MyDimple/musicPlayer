import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window


ToolBar{//顶部工具栏
    property point point: Qt.point(x,y)
     property bool isSmallWindow: false
    background: Rectangle{
        color:"#00000000"
        }
    width: parent.width
    Layout.fillWidth: true
    RowLayout{
        anchors.fill:parent

        MusicToolButton{
            iconSource: "qrc:/images/music"
            toolTip: "关于"

        }
        MusicToolButton{
            iconSource: "qrc:/images/about"
            toolTip: "官网"
        }
        MusicToolButton{
                    id:smallWindow
                    iconSource: "qrc:/images/small-window"
                    toolTip: "小窗播放"
                    visible: !isSmallWindow
                    onClicked: {
                        isSmallWindow = true
                        setWindowSize(400,600)
                        pageHomeView.visible = false
                        pageDetailView.visible = true
                        appBackground.showDefaultBackground =  pageHomeView.visible
                    }
                }

        MusicToolButton{
                    id:normalWindow
                    iconSource: "qrc:/images/exit-small-window"
                    toolTip: "退出小窗播放"
                    visible: isSmallWindow
                    onClicked: {
                        setWindowSize()
                        isSmallWindow = false
                        appBackground.showDefaultBackground =  pageHomeView.visible
                    }
                }
        Item{
            visible:! _layoutHeaderView.isSmallWindow
            Layout.fillWidth: true
            Layout.fillHeight: true
            height: 32

            Text{
                anchors.centerIn: parent
                text:qsTr("welcome to freemusic")
                font.family: "微软雅黑"
                font.pointSize: 15
                color:"#ffffff"
                    }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed:  setPoint(mouseX,mouseY)
                onMouseXChanged: moveX(mouseX)
                onMouseYChanged: moveY(mouseY)
                onClicked: {
                console.log("clic....")}
            }

            }
        MusicToolButton{
            iconSource: "qrc:/images/minimize-screen"
            toolTip: "最小化"
            onClicked: {
                           window.hide()
                       }
        }

        MusicToolButton{
                    id:resize
                    icon.source: "qrc:/images/small-screen"
                    toolTip: "退出全屏"
                    visible: false
                    onClicked: {
                        setWindowSize()
                        window.visibility = Window.AutomaticVisibility
                        maxWindow.visible = true
                        resize.visible = false
                    }
                }

        MusicToolButton{
                    id:maxWindow
                    icon.source: "qrc:/images/full-screen"
                    toolTip: "全屏"
                    onClicked: {
                        window.visibility = Window.Maximized
                        maxWindow.visible = false
                        resize.visible = true
                    }
                }

        MusicToolButton{
                   icon.source: "qrc:/images/power"
                   toolTip: "退出"
                   onClicked: {
                       Qt.quit()
                   }
               }
    }

    function setWindowSize(width = window.mWINDOW_WIDTH,height = window.mWINDOW_HEIGHT){
            window.width = width
            window.height = height
            window.x=(Screen.desktopAvailableWidth-window.width)/2
            window.y=(Screen.desktopAvailableHeight-window.height)/2
        }

    function setPoint(mouseX =0 ,mouseY = 0){
            point =Qt.point(mouseX,mouseY)
            //console.log(mouseX,mouseY)
        }

        function moveX(mouseX = 0 ){
            var x = window.x + mouseX-point.x
            if(x<-(window.width-70)) x = - (window.width-70)
            if(x>Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
            window.x = x
        }

        function moveY(mouseY = 0 ){
            var y = window.y + mouseY-point.y
            if(y<=0) y = 0
            if(y>Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
            window.y = y
        }
}
