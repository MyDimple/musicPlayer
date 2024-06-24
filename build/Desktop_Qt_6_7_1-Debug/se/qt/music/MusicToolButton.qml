import QtQuick 2.12
import QtQuick.Controls 2.5

//自定义ToolButton
ToolButton{
    property string iconSource: ""
    property string toolTip: ""

    property bool isCheckable:false
    property bool isChecked:false
    property int iconWidth: 20
    property int iconHeight: 20

    id:self

    icon.source:iconSource
    icon.height: iconHeight
    icon.width: iconWidth

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    background: Rectangle{//点击效果
        color: self.down||(isCheckable&&self.checked)?"#eeeeee":"#00000000"
    }
    icon.color: self.down||(isCheckable&&self.checked)?"#00000000":"#eeeeee"

    checkable: isCheckable
    checked: isChecked
}
