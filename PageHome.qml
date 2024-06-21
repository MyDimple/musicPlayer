import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout{
    Layout.fillHeight: true;
    spacing: 0

    LeftNavigation{
        Layout.fillHeight: true;
        width:200;
    }
    Content{
        Layout.fillHeight: true;
        Layout.fillWidth: true;
        border.color: "black";
        radius: 10
        border.width: 1
    }
}
