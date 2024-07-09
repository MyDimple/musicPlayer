import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import "freems.js" as Control
ColumnLayout{
    spacing: 0
    Rectangle{
        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#ffffff"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("我的喜欢")
            font.family: "宋体"
            font.pointSize: 25
            color: "black"
        }
    }

    Rectangle{
        Layout.fillWidth: true
        height: 80
        color:"#ffffff"
        RowLayout{
            height: parent
            Item{
                width: 5
            }
            MusicTextButton{
                btnText: "刷新记录"
                btnHeight: 50
                btnWidth: 120
                onClicked: Control.getFavorite()
            }
            MusicTextButton{
                btnText: "清空记录"
                btnHeight: 50
                btnWidth: 120
                onClicked: Control.clearFavorite()
            }

        }
    }



    MusicListView{
        id:favoriteListView
        favoritable: false
        onDeleteItem: Control.deleteFavorite(index)
    }

    Component.onCompleted: {
        Control.clearFavorite()
    }



}
