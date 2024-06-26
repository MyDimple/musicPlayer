import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Qt.labs.platform
import QtCore
import QtQml

//历史播放布局
ColumnLayout{

    // Settings{
    //     id:historySettings
    //     location: "conf/history.ini"
    // }

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("播放历史")
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
            onClicked: getHistory()
        }

        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearHistory()
        }

    }

    MusicListView{
        id:historyListView
        onDeleteItem: deleteHistory(index)
    }

    Component.onCompleted: {
        getHistory()
    }
    //删除键功能
    function deleteHistory(index){
            var list =historySettings.value("history",[])
            if(list.length<index+1)return
            list.splice(index,1)
            historySettings.setValue("history",list)
            getHistory()
        }

    //刷新记录
    function getHistory(){
        historyListView.musiclist = historySettings.value("history",[])
    }

    //清空记录
    function clearHistory(){
         historySettings.setValue("history",[])
        getHistory()
    }
}
