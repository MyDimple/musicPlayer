import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import se.qt.music
import "freems.js" as Control
ScrollView{
    clip:true //裁剪超出部分

    background: Rectangle{
        color:"#ffffff"
        radius: 10
        border.width: 1
        border.color: "black"
    }

    ColumnLayout {

        //推荐内容
        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height:60
            color: "#00000000"
            Text{
                x:10
                verticalAlignment: Text.AlignBottom
                text:qsTr("推荐内容")
                font.family: "宋体"
                font.pointSize: 25
                color: "black"
            }
        }

        //轮播图
        MusicBannerView{
            id:bannerView
            Layout.preferredHeight: (Window.width-200)*0.3
            Layout.preferredWidth: Window.width-200
            Layout.fillWidth:true
            Layout.fillHeight:true
            background: Rectangle{
                radius: 10
                border.color: "grey"
                border.width: 1
            }
        }

        //热门歌单
        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height:60
            color: "#ffffff"
        Text{
            x:10
            verticalAlignment: Text.AlignBottom
            text:qsTr("热门歌单")
            font.family: "微软雅黑"
            font.pointSize: 18
            }
        }
        HotMusic{
            id:hotMusic
            Layout.fillWidth: true
            Layout.fillHeight:true
            Layout.preferredHeight: (Window.width-250)*0.2*4+30*4
        }
        Item{
            height: 40
            Layout.fillWidth: true
        }
    }

    Search{
        id:se
        Component.onCompleted: {

           Control.getBannerList()

        }
    }



}
