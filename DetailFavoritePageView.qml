import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

//我喜欢的布局
ColumnLayout{

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("我喜欢的")
            font.family: "微软雅黑"
            font.pointSize: 25
            color: "white"

        }
    }

    RowLayout{
        height: 80
        Item{
            width: 5
        }
        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: getFavorite()
        }

        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearFavorite()
        }

    }

    MusicListView{
        id:favoriteListView
        favoritable: false
        onDeleteItem: deleteFavorite(index)
    }

    Component.onCompleted: {
        getFavorite()
    }

    //删除喜欢
    function deleteFavorite(index){
            var list =favoriteSettings.value("favorite",[])
            if(list.length<index+1)return
            list.splice(index,1)
            favoriteSettings.setValue("favorite",list)
            getFavorite()
        }

    //刷新，获取喜欢
    function getFavorite(){
        favoriteListView.musiclist = favoriteSettings.value("favorite",[])
    }

    //删除键功能
    function clearFavorite(){
            favoriteSettings.setValue("favorite",[])
            getFavorite()
        }

}
