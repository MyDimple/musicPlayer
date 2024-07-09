import QtQuick 2.12
import QtQuick.Controls 2.5

//自定义button
Button{
    property string iconSource: ""

    property string toolTip: ""

    property bool isCheckable:false
    property bool isChecked:false

    property int iconWidth: 28
    property int iconHeight: 28

    id:self

    icon.source:iconSource
    icon.height: iconHeight
    icon.width: iconWidth

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    background: Rectangle{//点击效果
        color: self.down||(isCheckable&&self.checked)?"#d6d4d4":"#ffffff"
        radius: 3
    }
    icon.color: self.down||(isCheckable&&self.checked)?"black":"grey"

    checkable: isCheckable
    checked: isChecked
}
