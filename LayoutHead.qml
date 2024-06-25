import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id:_head
    Layout.fillWidth: true;
    height:60
    RowLayout{
        anchors.fill: parent
        spacing: 0
        Logo{
            id: logo
            height:_head.height
            width:200
        }
        SearchView{
            id:_search
            height:_head.height
            Layout.fillWidth: true

        }
        Setting{
            id:_setting
            height:_head.height/2
            Layout.alignment: Qt.AlignVCenter
            width:220
            Layout.margins: 5
            radius: 10
            border.color: "black"
        }
    }
}


