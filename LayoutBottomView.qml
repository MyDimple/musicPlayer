import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
//底部工具栏
Rectangle{
    property var playList: []
    property int current:0
    property int sliderValue: 0
    property int sliderFrom: 0
    property int sliderTo: 100
    Layout.fillWidth: true
    height: 60
    color: "#00AAAA"

    RowLayout{
            anchors.fill: parent

            Item{
                Layout.preferredWidth: parent.width/10
                Layout.fillWidth: true
                }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/previous"
                toolTip: "上一曲"
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/stop"
                toolTip: "暂停"
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/next"
                toolTip: "下一曲"
            }

            Item{
                Layout.preferredWidth: parent.width/2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: 30

                Text{
                    id:_nameText
                    anchors.left: _slider.left
                    anchors.bottom: _slider.top
                    anchors.leftMargin: 2
                    text:"歌名-歌手"
                    color: "#ffffff"
                }

                Text{
                    id:_timeText
                    anchors.right: _slider.right
                    anchors.bottom: _slider.top
                    anchors.rightMargin: 2
                    text:"00:00/05:30"
                    color: "#ffffff"
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
                        color: "#e9f4ff"
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
                id:musicCover
                width: 50
                height: 50

            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/favorite"
                toolTip: "喜欢"
            }
            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/repeat"
                toolTip: "重复播放"
            }

            Item{
                Layout.preferredWidth: parent.width/10
                Layout.fillWidth: true
                }

    }
    function playMusic(index=0){

        getUrl(index)

    }
    //获取播放链接
    function getUrl(index){
        if(playList.length<1)return
        var id=playList[index].id
        if(!id)return
        //设置详情
        _nameText.text=playList[index].name+"/"+playList[index].artist

        function onReply(reply) {
            se.onReplySignal.disconnect(onReply)
            var data=JSON.parse(reply).data[0]
            var url = data.url
            var time=data.time
            //设置Slider
            setSlider(0,time,0)

            if(!url)return
            //获取封面
            var cover = playList[index].cover
            if(cover.length<1){
                getCover(id)
            }else{
                musicCover.imgSrc=cover
            }

            mediaplayer.source=url
            mediaplayer.play()
            console.log(url)
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("song/url?id="+id); // 触发网络请求
    }

    function setSlider(from=0,to=100,value=0){
        sliderFrom=from
        sliderTo=to
        sliderValue=value

        var from_mm=parseInt(value/1000/60)+""
        from_mm=from_mm.length<2?"0"+from_mm:from_mm
        var from_ss=parseInt(value/1000%60)+""
        from_ss=from_ss.length<2?"0"+from_ss:from_ss

        var to_mm=parseInt(to/1000/60)+""
        to_mm=to_mm.length<2?"0"+to_mm:to_mm
        var to_ss=parseInt(to/1000%60)+""
        to_ss=to_ss.length<2?"0"+to_ss:to_ss

        _timeText.text=from_mm+":"+from_ss+"/"+to_mm+":"+to_ss
    }

    function getCover(id,index){
        function onReply(reply) {
            se.onReplySignal.disconnect(onReply)
            var cover=JSON.parse(reply).songs[0].al.picUrl
            if(cover){
                musicCover.imgSrc=url
            }
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("song/datail?ids="+id); // 触发网络请求

    }
}
