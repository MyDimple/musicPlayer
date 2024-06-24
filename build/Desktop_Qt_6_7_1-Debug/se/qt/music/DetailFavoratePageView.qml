import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout{
    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr(targetType=="10"?"专辑":"歌单")+name //歌单或者专辑名字
            font.family: "微软雅黑"
            font.pointSize: 25
        }
    }
    RowLayout{

    }
    MusicListView{
        id:localListView
    }
}
