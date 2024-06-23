import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import se.qt.music
ApplicationWindow {
    id:window
    width: 1200
    height: 800
    visible: true
    color:"white"


    Search{
        id:se
        // Component.onCompleted: {

        //    searchonline()

        // }
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
        id:layoutHeaderView
        }


    //中部模块
    PageHomeView{
        id:pageHomeView
        }

    //底部模块
    LayoutBottomView{
        id:layoutBottomView
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
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}

