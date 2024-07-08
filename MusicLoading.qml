import QtQuick
import Qt5Compat.GraphicalEffects

//搜索加载动画
Item {

    property Item parentWindow: parent

    id:self

    visible: false
    scale: visible

    width:200
    height:180

    anchors.centerIn: parentWindow
    DropShadow{
        anchors.fill: rect
        radius: 8
        horizontalOffset: 1
        verticalOffset:1
        samples: 16
        color: "#60000000"
        source: rect
    }

    Rectangle{
        id:rect
        color: "#4003a9f4"
        radius: 5
        anchors.fill: parent

        Image{
            id:image
            source: "qrc:/images/loading"
            width: 50
            height: 50
            anchors.centerIn: parent
            NumberAnimation {
                property: "rotation"
                from:0
                to:360
                target: image
                loops:Animation.Infinite
                running: self.visible
                duration: 500
            }
        }

        Text{
            id:content
            text:"Loading..."
            color: "#eeffffff"
            font{
                family: "微软雅黑"
                pointSize: 11
            }
            anchors{
                top:image.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function open(){
        visible = true
    }

    function close(){
        visible = false
    }

}
