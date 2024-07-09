import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import "freems.js" as Control
//底部工具栏
Rectangle{
      property alias timeText: _timeText
    property var playList: []
    property int current:-1
    property int sliderValue: 0
    property int sliderFrom: 0
    property int sliderTo: 100
    property int currentPlayMode: 0
    property var playModeList: [{icon:"qrc:/icons/singlecycle.png",name:"单曲循环"},{icon:"qrc:/icons/shunxubofang.png",name:"列表循环"},{icon:"qrc:/icons/suijibofang.png",name:"随机播放"}]
    property bool isModelChange: false
    property bool isPressed: false
    property string musicName: "music"
    property string artistName: "music"
    property string musicCover: "qrc:/icons/tingquanmao.png"
    property int playingState: 0
    Layout.fillWidth: true
    height: 60
    color: "#f3f3f3"

    RowLayout{
            anchors.fill: parent

            Item{
                Layout.preferredWidth: parent.width/10
                Layout.fillWidth: true
                }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/icons/shangyiqu.png"
                toolTip: "上一曲"
                onClicked: Control.playPrevious()
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:playingState?"qrc:/icons/zanting.png":"qrc:/icons/bofang.png"
                toolTip: playingState?"暂停":"播放"
                onClicked: Control.playOrPause()
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/icons/xiayiqu.png"
                toolTip: "下一曲"
                onClicked: Control.playNext("")
            }

            Item{
                 visible: !_layoutHeaderView.isSmallWindow
                Layout.preferredWidth: parent.width/2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: 30

                Text{
                    id:_nameText
                    anchors.left: _slider.left
                    anchors.bottom: _slider.top
                    anchors.leftMargin: 2
                    text:musicName+"-"+artistName
                    color: "black"
                }

                Text{
                    id:_timeText
                    anchors.right: _slider.right
                    anchors.bottom: _slider.top
                    anchors.rightMargin: 2
                    text:"00:00/00:00"
                    color: "black"
                }

                //进度条
                Slider{
                    id:_slider
                    width:parent.width
                    Layout.fillWidth: true
                    enabled: mediaplayer.seekable
                    to: 1.0
                    // to:sliderTo
                    // from:sliderFrom
                    // value: sliderValue


                    value:mediaplayer.position/mediaplayer.duration
                    onMoved: mediaplayer.setPosition(_slider.value * mediaplayer.duration)

                    height:25
                    background: Rectangle{
                        x:_slider.leftPadding
                        y:_slider.topPadding + (_slider.availableHeight-height)/2
                        width:_slider.availableWidth
                        height:4
                        radius: 2
                        color: "#ffffff"
                        Rectangle{//实现拖动颜色变化
                            width: _slider.visualPosition*parent.width
                            height: parent.height
                            color:"grey"
                            radius: 2
                        }
                    }

                    handle:Rectangle{
                        x:_slider.topPadding + (_slider.availableWidth-width)*_slider.visualPosition //拖动效果
                        y:_slider.topPadding + (_slider.availableHeight-height)/2
                        width: 15
                        height: 15
                        radius: 5
                        color: "#f0f0f0"
                        border.color: "#73a7ab"
                        border.width: 0.5
                    }
                }
            }

            MusicRoundImage{
                // id:musicCover
                visible: !_layoutHeaderView.isSmallWindow
                width: 50
                height: 45
                imgSrc: musicCover
                //点击事件进入歌曲详情页面
                TapHandler{
                    // anchors.fill: parent

                    onTapped: {
                        pageHomeView.visible=!pageHomeView.visible
                        pageDetailView.visible=!pageDetailView.visible

                        if (isPressed) {
                            musicCover.scale = 0.9
                            isPressed = false
                        } else {
                            musicCover.scale = 1.0
                            isPressed = true
                        }
                        // musicCover.scale=1.0
                    }

                }
                HoverHandler{
                    cursorShape: Qt.PointingHandCursor
                }

            }

            MusicIconButton{
                        Layout.preferredWidth: 50
                        icon.source: "qrc:/icons/xihuan_1.png"
                        iconWidth: 32
                        iconHeight: 32
                        toolTip: "我喜欢"
                        onClicked: Control.saveFavorite( playList[current])
                    }
            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:playModeList[currentPlayMode].icon
                toolTip: playModeList[currentPlayMode].name
                onClicked: Control.changePlayMode()
            }

            Item{
                Layout.preferredWidth: parent.width/10
                Layout.fillWidth: true
                }

    }




    Component.onCompleted: {
        //从配置文件中拿到currentPlayMode
         currentPlayMode=settings.value("currentPlayMode",0)
    }

    onCurrentChanged: {
        //只要改变了数据项就禁止掉防止自己循环
        isModelChange=false
        Control.playMusic(current)
    }


}
