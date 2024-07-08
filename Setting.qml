import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    RowLayout{
        // anchors.right: parent.right
        // anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent

        ToolButton{
            icon.source: "qrc:/icon_black/zhiding.png"
            onClicked: {

            }
        }

        ToolButton{
            icon.source: "qrc:/icon_black/shezhi.png"
        }

        ToolSeparator{}

        ToolButton{
            // text:"narrow"
            icon.source: "qrc:/icon_black/shousuoxiala.png"

            property var rect: Qt.rect(x,y,width,height)
            property bool isWithinBound:true

            onClicked: _window.showMinimized()
        }

        ToolButton{
            id:_size
            icon.source: "qrc:/icon_black/fangda.png"
            // font.pixelSize: 10

            property bool isMaximized: false

            onClicked: {
                if(isMaximized){
                    _window.showNormal()
                    isMaximized = false
                    _size.icon.source = "qrc:/icon_black/fangda.png"
                } else{
                    _window.showMaximized()
                    isMaximized = true
                    _size.icon.source = "qrc:/icon_black/suoxiao.png"
                }
            }
        }

        ToolButton{
            icon.source: "qrc:/icon_black/guanbi.png"
            onClicked: Qt.quit()
        }
    }
}
