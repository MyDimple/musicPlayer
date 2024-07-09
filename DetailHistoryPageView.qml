import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Qt.labs.platform
import QtCore
import QtQml
import "freems.js" as Control
//历史播放布局
ColumnLayout{
    spacing: 0
    // Settings{
    //     id:historySettings
    //     location: "conf/history.ini"
    // }

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#ffffff"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("播放历史")
            font.family: "宋体"
            font.pointSize: 25
            color: "black"

        }
    }

    Rectangle{
        Layout.fillWidth: true
        height: 80
        color: "#ffffff"
        RowLayout{
            height: parent
            Item{
                width: 5
            }

            MusicTextButton{
                btnText: "刷新记录"
                btnHeight: 50
                btnWidth: 120
                onClicked: Control.getHistory()
            }

            MusicTextButton{
                btnText: "清空记录"
                btnHeight: 50
                btnWidth: 120
                onClicked: Control.clearHistory()
            }
        }
    }

    MusicListView{
        id:historyListView
        onDeleteItem: Control.deleteHistory(index)
    }

    Component.onCompleted: {
        Control.clearHistory()
    }

}
