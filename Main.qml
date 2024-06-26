import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt.labs.settings 1.1
import se.qt.music
import QtQml
ApplicationWindow {
    property string organizationName: "MyOrganization"
    property string organizationDomain: "myorganization.com"

    id:window
    width: 1200
    height: 800
    visible: true
    color:"white"
    background: Background{
            id:appBackground
        }
    Search{
        id:se
        // Component.onCompleted: {

        //    searchonline()

        // }
    }

    //设置我喜欢的音乐保存路径
    Settings{
            id:favoriteSettings
            fileName: "conf/favorite.ini"
        }


    Settings{
        id:settings
        fileName: "conf/settings.ini"
    }

    //设置播放历史保存路径
    Settings{
        id:historySettings
        fileName: "conf/history.ini"
    }



//     function searchonline() {
//         function onReply(reply) {
//             // console.log("hello")
//             console.log(reply);
//             // 处理接收到的回复
//         }
//         se.onReplySignal.connect(onReply)
//         se.concatenate("banner"); // 触发网络请求

//         // if (se.onReplySignal.connections > 0) {
//         //        console.log("Signal is connected.");
//         //    } else {
//         //        console.log("Signal is not connected.");
//         //    }
// }


    //布局
    ColumnLayout{
        anchors.fill: parent
        spacing: 0

    //上部模块
    LayoutHeaderView{
        id:_layoutHeaderView
        }


    //中部模块
    PageHomeView{
        id:_pageHomeView
        }

    //底部模块
    LayoutBottomView{
        id:_layoutBottomView
        }

    }

    //音乐播放,后面再改
    MediaPlayer {
        id: mediaplayer
        // source: ""
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
        onPositionChanged: {
            _layoutBottomView.setSlider(0,duration,position)

        }
        onPlaybackStateChanged: {
            //添加isModelChange控制播放
            if(playbackState===MediaPlayer.StoppedState&&_layoutBottomView.isModelChange)
            {
                _layoutBottomView.playNext()
            }
        }
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}

