import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import QtCore
import se.qt.music
import QtQml
import "freems.js" as Control
ApplicationWindow {
    property string organizationName: "MyOrganization"
    property string organizationDomain: "myorganization.com"
    property int mWINDOW_WIDTH: 1200
    property int mWINDOW_HEIGHT: 800
    id:window
    width: 1200
    height: 800
    visible: true

    Search{
        id:se

    }
    //注册搜索出错弹窗
    MusicNotification{
            id:notification
        }

    //注册系统托盘
    AppSystemTrayIcon{

        }
    //注册搜索加载动画
    MusicLoading{
    id:loading
    }
    //设置我喜欢的音乐保存路径
    Settings{
            id:favoriteSettings
            location: "conf/favorite.ini"
        }


    Settings{
        id:settings
        location: "conf/settings.ini"
    }

    //设置播放历史保存路径
    Settings{
        id:historySettings
        location: "conf/history.ini"
    }




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
        id:pageHomeView

        // visible: false

        }
    //歌曲详情
    PageDetailView{
        id:pageDetailView
        visible: false
    }

    //底部模块
    LayoutBottomView{
        id:layoutBottomView
        }

    }

    //音乐播放,后面再改
    MediaPlayer {
        property var times: []
        id: mediaplayer
        // source: ""
        audioOutput: AudioOutput {}
        videoOutput: videoOutput


        onPositionChanged: {
            //更新进度条
            Control.setSlider(0,duration,mediaplayer.position)
            // var adjustedPosition = mediaplayer.position ;
            if(times.length>0){
                var count=times.filter(time=>time<mediaplayer.position ).length
                pageDetailView.current=(count===0)?0:count-1
            }

        }


        onPlaybackStateChanged: {
            layoutBottomView.playingState=playbackState===MediaPlayer.PlayingState?1:0
            //添加isModelChange控制播放
            if(playbackState===MediaPlayer.StoppedState&&layoutBottomView.isModelChange)
            {
                Control.playNext()
            }
        }
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
  }


