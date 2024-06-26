import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
//底部工具栏
Rectangle{
    property var playList: []
    property int current:-1
    property int sliderValue: 0
    property int sliderFrom: 0
    property int sliderTo: 100
    property int currentPlayMode: 0
    property var playModeList: [{icon:"single-repeat",name:"单曲循环"},{icon:"repeat",name:"循环播放"},{icon:"random",name:"随机播放"}]
    property bool isModelChange: false
    property bool isPressed: false
    property string musicName: "music"
    property string artistName: "music"
    property string musicCover: "qrc:/images/player"
    property int playingState: 0
    Layout.fillWidth: true
    height: 60
    color: "#1000AAAA"

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
                onClicked: playPrevious()
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:playingState?"qrc:/images/stop":"qrc:/images/pause"
                toolTip: "暂停"
                onClicked: {
                    if(!mediaplayer.source)return
                    if(mediaplayer.playbackState===MediaPlayer.PlayingState){
                        mediaplayer.pause()
                        playingState=0
                        // iconSource="qrc:/images/pause"
                    }else if(mediaplayer.playbackState===MediaPlayer.PausedState){
                        mediaplayer.play()
                        playingState=1
                        // iconSource="qrc:/image/stop"
                    }
                }
            }

            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/next"
                toolTip: "下一曲"
                onClicked: playNext("")
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
                    text:musicName+"-"+artistName
                    color: "#ffffff"
                }

                Text{
                    id:_timeText
                    anchors.right: _slider.right
                    anchors.bottom: _slider.top
                    anchors.rightMargin: 2
                    text:"00:00/00:00"
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
                // id:musicCover
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
                        icon.source: "qrc:/images/favorite"
                        iconWidth: 32
                        iconHeight: 32
                        toolTip: "我喜欢"
                        onClicked: saveFavorite( playList[current])
                    }
            MusicIconButton{
                Layout.preferredWidth: 50
                iconSource:"qrc:/images/"+playModeList[currentPlayMode].icon
                toolTip: playModeList[currentPlayMode].name
                onClicked: changePlayMode()
            }

            Item{
                Layout.preferredWidth: parent.width/10
                Layout.fillWidth: true
                }

    }


    // 保存历史记录
    function saveHistory(index = 0){
        if(playList.length < index + 1) return
        var item = playList[index]
        if(!item||!item.id)return
        var history = historySettings.value("history",[])
        if(i>=0) history.splice(i,1)
        var i = history.findIndex(value=>value.id===item.id)
        if(i >= 0){
            history.slice(i,1)
        }
        history.unshift({
                            id:item.id + "",
                            name:item.name,
                            artist:item.artist,
                            url:item.url?item.url:"",
                            type:item.type?item.type:"",
                            album:item.album?item.album:"本地音乐"

                        })
        if(history.length > 100)
        {//限制一百条数据
            history.pop()}
        historySettings.setValue("history",history)

    }

    //保存我喜欢
    function saveFavorite(value={}){
           if(!value||!value.id)return
           var favorite =  favoriteSettings.value("favorite",[])
           var i =  favorite.findIndex(item=>value.id===item.id)
           if(i>=0) favorite.splice(i,1)
           favorite.unshift({
                               id:value.id+"",
                               name:value.name+"",
                               artist:value.artist+"",
                               url:value.url?value.url:"",
                               type:value.type?value.type:"",
                               album:value.album?value.album:"本地音乐"
                           })
           if(favorite.length>500){
               //限制五百条数据
               favorite.pop()
           }
           favoriteSettings.setValue("favorite",favorite)
       }

    //播放音乐，判断网络还是本地音乐
    function playMusic(){
           if(current<0)return
           if(playList.length<current+1) return
           //获取播放链接
           if(playList[current].type==="1"){
               //播放本地音乐
               playLocalMusic()
           } else {
               //播放网络音乐
               playWebMusic()
           }
           saveHistory(current)
       }

    //播放本地音乐
    function playLocalMusic(){
           var currentItem = playList[current]
           mediaplayer.source =currentItem.url
           mediaplayer.play()
           _nameText.text=playList[current].name+"/"+playList[current].artist
       }

    //播放网络音乐
    function playWebMusic(){
        var id=playList[current].id
        if(!id)return
        //设置详情
        _nameText.text=playList[current].name+"/"+playList[current].artist
        function onReply(reply) {
            se.onReplySignal.disconnect(onReply)
            var data=JSON.parse(reply).data[0]
            var url = data.url
            var time=data.time
            //设置Slider
            setSlider(0,time,0)

            if(!url)return
            //获取封面
            var cover = playList[current].cover
            if(cover.length<1){
                getCover(id)
            }else{
                musicCover=cover
            }
            mediaplayer.source=url
            mediaplayer.play()
            isModelChange=true
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("song/url?id="+id); // 触发网络请求
    }


    Component.onCompleted: {
        //从配置文件中拿到currentPlayMode
         currentPlayMode=settings.value("currentPlayMode",0)
    }

    onCurrentChanged: {
        //只要改变了数据项就禁止掉防止自己循环
        isModelChange=false
        playMusic(current)
    }

    //播放上一首
    function playPrevious(){
        if(playList.length<1){
            return
        }


        switch(currentPlayMode)
        {
            //单曲播放
        case 0:

            //循环播放
        case 1:
            //&playList.length该操作是避免它为负数
            current=(current+playList.length-1)%playList.length
            break
            //随机播放
        case 2:{
            var random=parseInt(Math.random()*playList.length)//parseInt是取整
            current=current===random?random+1:random
            break
        }
        }
    }

    //播放下一首
    function playNext(type='natural'){
        if(playList.length<1){
            return
        }

        switch(currentPlayMode)
        {
            //单曲播放
        case 0:
            if(type==='natural'){
                mediaplayer.play()
                break
            }

            //循环播放
        case 1:
            //&playList.length该操作是避免它为负数
            current=(current+1)%playList.length
            break
            //随机播放
        case 2:{
            var random=parseInt(Math.random()*playList.length)//parseInt是取整
            current=current===random?random+1:random
            break
        }
        }


    }

    //切换播放模式
    function changePlayMode(){
        // console.log("look",currentPlayMode)
        currentPlayMode=(currentPlayMode+1)%playModeList.length
        settings.setValue("currentPlatMode",currentPlayMode)
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

    function getCover(id){
        function onReply(reply) {
            se.onReplySignal.disconnect(onReply)
            getLyric(id)
            var song=JSON.parse(reply).songs[0]
            var cover=song.al.picUrl
            musicCover=cover

            if(musicName.length<1)
            {
                musicName=song.name
            }
            if(artistName.length<1)
            {
                artistName=song.ar[0].name
            }

            pageHomeView.visible=!pageHomeView.visible
            pageDetailView.visible=!pageDetailView.visible
        }
        // console.log("hello")
        se.onReplySignal.connect(onReply)
        se.concatenate("song/datail?ids="+id); // 触发网络请求

    }
    function getLyric(id){
            function onReply(reply){
                http.onReplySignal.disconnect(onReply)
                var lyric = JSON.parse(reply).lrc.lyric
                console.log(lyric)
                if(lyric.length<1) return
                var lyrics = (lyric.replace(/\[.*\]/gi,"")).split("\n")

                if(lyrics.length>0) pageDetailView.lyricsList = lyrics

                var times = []
                lyric.replace(/\[.*\]/gi,function(match,index){
                    //match : [00:00.00]
                    if(match.length>2){
                        var time  = match.substr(1,match.length-2)
                        var arr = time.split(":")
                        var timeValue = arr.length>0? parseInt(arr[0])*60*1000:0
                        arr = arr.length>1?arr[1].split("."):[0,0]
                        timeValue += arr.length>0?parseInt(arr[0])*1000:0
                        timeValue += arr.length>1?parseInt(arr[1])*10:0

                        times.push(timeValue)
                    }
                })
            }
            http.onReplySignal.connect(onReply)
            http.connet("lyric?id="+id)
        }
}
