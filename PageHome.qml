import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout{
    Layout.fillHeight: true;
    spacing: 0

    Rectangle{
        Layout.fillHeight: true;
        width:200;
        border.color: "black";
        border.width: 1
    }
    Rectangle{
        Layout.fillHeight: true;
        Layout.fillWidth: true;
        border.color: "black";
        border.width: 1
    }
}
