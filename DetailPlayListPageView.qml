import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import se.qt.music
import "freems.js" as Control
//专辑歌单页面布局,隐藏的，点击歌单，歌单的内容就是这个
ColumnLayout{
    property string targetId: ""
    property string targetType:"10"//album,playlist/detail
    property string name: "-"

    spacing: 0

    onTargetIdChanged:{//获取专辑或者歌单数据
        if(targetType=="10") Control.loadAlbum() //专辑
        else if(targetType=="1000") Control.loadPlayList() //歌单
    }

    Rectangle{
        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#ffffff"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr(targetType=="10"?"专辑":"歌单")+name //歌单或者专辑名字
            font.family: "宋体"
            font.pointSize: 25
            color: "black"
        }
    }

    Rectangle{
        height: 200
        // width: parent.width
        Layout.fillWidth: true
        color:"#ffffff"
        border.width: 1
        border.color: "black"
        // radius: 15
        RowLayout{
            height: parent.height
            width: parent.width
            MusicRoundImage{
                id:playListCover
                width: 180
                height: 180
                Layout.leftMargin: 15
            }

            Item{
                Layout.fillWidth: true
                height: parent.height

                Text{
                    id:playListDesc
                    width: parent.width*0.95
                    anchors.centerIn: parent
                    wrapMode: Text.WrapAnywhere
                    font.family: "微软雅黑"
                    font.pointSize: 14
                    maximumLineCount: 4
                    elide: Text.ElideRight
                    lineHeight: 1.5
                    color:"grey"
                }
            }
        }
    }



    MusicListView{
        id:playListListView
        deletable: false //隐藏删除键
    }


    Search{
        id:se
    }


}

