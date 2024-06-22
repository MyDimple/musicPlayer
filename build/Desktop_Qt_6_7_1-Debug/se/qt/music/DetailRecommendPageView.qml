import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import se.qt.music

ScrollView{
    clip:true //裁剪超出部分
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
            font.family: "微软雅黑"
            font.pointSize: 18
        }
        }

        //轮播图
        MusicBannerView{
            id:bannerView
            Layout.preferredHeight: (Window.width-200)*0.3
            Layout.preferredWidth: Window.width-200
            Layout.fillWidth: true
            Layout.fillHeight:true
        }

        //热门歌单
        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height:60
            color: "#00000000"
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

    }


    Search{
        id:se
        Component.onCompleted: {

           getBannerList()

        }
    }

    //获取轮播图
    function getBannerList() {
        function onReply(reply) {
            // console.log("hello")
            // console.log(reply);
            // 处理接收到的回复
            se.onReplySignal.disconnect(onReply)
            var banners = JSON.parse(reply).banners
            bannerView.bannerList = banners
            getHotMusic() //在轮播图中调用getHotMusic()，因为方法异步有可能出现只获取了一个
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("banner"); // 触发网络请求
}

    //获取精品歌单
    function getHotMusic() {
        function onReply(reply) {
            // console.log("hello")
            // console.log(reply);
            // 处理接收到的回复
            se.onReplySignal.disconnect(onReply)
            var playlists = JSON.parse(reply).playlists
            hotMusic.list = playlists
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("top/playlist/highquality?limit=20"); // 触发网络请求
    }

}
