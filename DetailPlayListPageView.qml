import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import se.qt.music

//专辑歌单页面布局,隐藏的，点击歌单，歌单的内容就是这个
ColumnLayout{
    property string targetId: ""
    property string targetType:"10"//album,playlist/detail
    property string name: "-"

    onTargetIdChanged:{//获取专辑或者歌单数据
        console.log(targetType)
        if(targetType=="10") loadAlbum() //专辑
        else if(targetType=="1000") loadPlayList() //歌单
    }

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr(targetType=="10"?"专辑":"歌单")+name //歌单或者专辑名字
            font.family: "微软雅黑"
            font.pointSize: 25
        }
    }

    RowLayout{
        height: 200
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
            }
        }
    }

    MusicListView{
        id:playListListView
    }


    Search{
        id:se
    }

    //获取专辑数据
    function loadAlbum(){

        var url = "album?id="+(targetId.length<1?"32311":targetId)

        function onReply(reply){
            se.onReplySignal.disconnect(onReply)
            var album = JSON.parse(reply).album
            var songs = JSON.parse(reply).songs
            playListCover.imgSrc = album.blurPicUrl
            playListDesc.text = album.description
            name = "-"+album.name
            playListListView.musiclist= songs.map(item=>{
                                                      return {
                                                          id:item.id,
                                                          name:item.name,
                                                          artist:item.ar[0].name,
                                                          album:item.al.name,
                                                          cover:""
                                                      }
                                                  })
        }

        se.onReplySignal.connect(onReply)
        se.concatenate(url); // 触发网络请求
    }

    //获取歌单数据
    function loadPlayList(){

        var url = "playlist/detail?id="+(targetId.length<1?"32311":targetId)


        function onSongDetailReply(reply){
            se.onReplySignal.disconnect(onSongDetailReply)
            var songs = JSON.parse(reply).songs
            playListListView.musiclist= songs.map(item=>{
                                                      return {
                                                          id:item.id,
                                                          name:item.name,
                                                          artist:item.ar[0].name,
                                                          album:item.al.name,
                                                          cover:""
                                                      }
                                                  })
        }

        function onReply(reply){
            se.onReplySignal.disconnect(onReply)
            var playlist = JSON.parse(reply).playlist
            playListCover.imgSrc = playlist.coverImgUrl
            playListDesc.text = playlist.description
            name = "-"+playlist.name
            var ids = playlist.trackIds.map(item=>item.id).join(",")
            se.onReplySignal.connect(onSongDetailReply)
            // se.connet("song/detail?ids="+ids)
            se.concatenate("song/detail?ids="+ids); // 触发网络请求

        }
        se.onReplySignal.connect(onReply)
        // se.connet(url)
        se.concatenate(url); // 触发网络请求

    }
}

