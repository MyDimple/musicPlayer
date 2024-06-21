import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout{
    Layout.fillWidth: true;
    property real u_height: 60
    spacing: 0
    Logo{
        height:parent.u_height;
        width:200;
        border.color: "black";
        border.width: 1
    }
    Rectangle{
        height:parent.u_height;
        Layout.fillWidth: true
        border.color: "black";
        border.width: 1
    }
    Rectangle{
        height:parent.u_height;
        width:200;
        border.color: "black";
        border.width: 1
    }
}
