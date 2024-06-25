import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    RowLayout {
        anchors.centerIn: parent
        spacing: 0
        width: _search.width*2/3
        height: 34
        TextField {
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: qsTr("请输入搜索歌名...")
            // background: Rectangle {
            //            color: "transparent"
            //            border.color: "black"
            //            border.width: 1
            //            radius:Qt.rect(20,0,0,20)
            //        }
        }
        Button{
            text: qsTr("搜索")
            Layout.fillHeight: true
            Layout.maximumWidth: 40
            // onClicked: console.log(parent.width)
        }
    }
}
