import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    RowLayout{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        ToolButton{
            text:"setting"
            font.pixelSize: 10
        }
        ToolSeparator{

        }
        ToolButton{
            text:"narrow"
            font.pixelSize: 10
        }

        ToolButton{
            text:"enlarge"
            font.pixelSize: 10
        }
        ToolButton{
            text:"exit"
            font.pixelSize: 10
            Layout.rightMargin: 5
        }
    }
}
