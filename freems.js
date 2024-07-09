// import "freems.js" as Control
//喜欢音乐
function deleteFavorite(index){
        var list =favoriteSettings.value("favorite",[])
        if(list.length<index+1)return
        list.splice(index,1)
        favoriteSettings.setValue("favorite",list)
        getFavorite()
    }

//刷新，获取喜欢
function getFavorite(){
    favoriteListView.musiclist = favoriteSettings.value("favorite",[])
}

//删除键功能
function clearFavorite(){
        favoriteSettings.setValue("favorite",[])
        getFavorite()
    }




//历史播放
//删除键功能
function deleteHistory(index){
        var list =historySettings.value("history",[])
        if(list.length<index+1)return
        list.splice(index,1)
        historySettings.setValue("history",list)
        getHistory()
    }

//刷新记录
function getHistory(){
    historyListView.musiclist = historySettings.value("history",[])
}

//清空记录
function clearHistory(){
     historySettings.setValue("history",[])
    getHistory()
}






//本地音乐
//获取本地音乐
function getLocal(){
    var list = localSettings.value("local",[])
    localListView.musiclist = list
    return list
}

function saveLocal(list=[]){
    localSettings.setValue("local",list)
    getLocal()
}

//删除键功能
function deleteLocal(index){
       var list =localSettings.value("local",[])
        if(list.length<index+1)return
        list.splice(index,1)
        saveLocal(list)
    }
//获取本地音乐歌词
function locallyc(lyric)
{
    if(lyric.length<1) return
    var lyrics = (lyric.replace(/\[.*\]/gi,"")).split("\n")
    // console.log(lyrics)
    if(lyrics.length>0) pageDetailView.lyrics = lyrics

    var times = []
    lyric.replace(/\[.*\]/gi,function(match,index){
        //match : [00:00.00]
        if(match.length>2){
            var time  = match.substr(1,match.length-2)
            var arr = time.split(":")
            var timeValue = arr.length>0? parseInt(arr[0])*60*1000:0
            arr = arr.length>1?arr[1].split("."):[0,0]
            timeValue += arr.length>0?parseInt(arr[0])*1000:0
            timeValue += arr.length>1?parseInt(arr[1]):0
            times.push(timeValue)
        }
    })
      mediaplayer.times=times
}



//主页内容
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
                                                      cover:item.al.picUrl
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
                                                      cover:item.al.picUrl
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



//轮播图
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

//获取精品歌单,即推荐内容下方网格
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

//搜索
function doSearch(offset=0,current=0)
{
    // console.log(offset)
    var keywords=searchInput.text
    if(keywords.length<1){
        return
    }

    function onReply(reply) {

        se.onReplySignal.disconnect(onReply)
        // console.log(reply);
        var result = JSON.parse(reply).result//获取并解析数据
        var songs = result.songs
        musiclistView.current=current
        musiclistView.all=result.songCount
        musiclistView.musiclist=songs.map(item=>{
                                              return{
                                                  id:item.id,
                                                  name:item.name,
                                                  artist:item.artists[0].name,
                                                  album:item.album.name,
                                                  cover:""
                                              }
                                          })
    }
    se.onReplySignal.connect(onReply)
    se.concatenate("search?keywords="+keywords+"&offset="+offset+"&limit=60"); // 触发网络请求
}

//底部内容
function playOrPause()
{
    if(!mediaplayer.source)return
    if(mediaplayer.playbackState===MediaPlayer.PlayingState){
        mediaplayer.pause()
        playingState=0
    }else if(mediaplayer.playbackState===MediaPlayer.PausedState){
        mediaplayer.play()
        playingState=1
    }
}

// 保存历史记录
function saveHistory(index = 0){
    if(playList.length < index + 1) return
    var item = playList[index]
    if(!item||!item.id)return
    var history = historySettings.value("history",[])
    var i = history.findIndex(value=>value.id===item.id)
    if(i >= 0){
        history.splice(i,1)
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
    if(playList.length<current+1)return
    var id=playList[current].id
    if(!id)return
    //设置详情
    musicName=playList[current].name
    artistName=playList[current].artist
    function onReply(reply) {
        se.onReplySignal.disconnect(onReply)
        var data=JSON.parse(reply).data[0]
        var url = data.url
        var time=data.time
        //设置Slider
        setSlider(0,time,0)

        if(!url)return
        //获取封面
        if (playList === undefined || playList.length <= current || playList[current] === undefined) {
            // Handle the error appropriately, e.g., log an error or show a message to the user
            console.error("Invalid index or undefined playlist.")
        } else {
            var cover = playList[current].cover
            if (cover === undefined || cover.length < 1) {
                getCover(id)
            } else {
                musicCover = cover
            }
        }
        getLyric(id)
        mediaplayer.source=url
        mediaplayer.play()
        isModelChange=true
    }
    se.onReplySignal.connect(onReply)
    se.concatenate("song/url?id="+id); // 触发网络请求
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
    layoutBottomView.sliderFrom=from
    layoutBottomView.sliderTo=to
    layoutBottomView.sliderValue=value

    var from_mm=parseInt(value/1000/60)+""
    from_mm=from_mm.length<2?"0"+from_mm:from_mm
    var from_ss=parseInt(value/1000%60)+""
    from_ss=from_ss.length<2?"0"+from_ss:from_ss

    var to_mm=parseInt(to/1000/60)+""
    to_mm=to_mm.length<2?"0"+to_mm:to_mm
    var to_ss=parseInt(to/1000%60)+""
    to_ss=to_ss.length<2?"0"+to_ss:to_ss

    layoutBottomView.timeText.text=from_mm+":"+from_ss+"/"+to_mm+":"+to_ss
}

function getCover(id){
    function onReply(reply) {
        se.onReplySignal.disconnect(onReply)
        var replyObject = JSON.parse(reply)
        if (replyObject && Array.isArray(replyObject.songs) && replyObject.songs.length > 0) {
            var song = replyObject.songs[0]
            if (song && song.al && song.al.picUrl) {
                var cover = song.al.picUrl
                musicCover = cover

                if (musicName.length < 1) {
                    musicName = song.name
                }
                if (artistName.length < 1) {
                    artistName = song.ar[0].name
                }

                pageHomeView.visible = !pageHomeView.visible
                pageDetailView.visible = !pageDetailView.visible
            } else {
                // Handle the case where song or song.al or song.al.picUrl is missing
                console.error("Invalid or incomplete song data in the reply.")
            }
        } else {
            // Handle the case where no songs are returned
            console.error("Invalid or missing song data in the reply.")
        }
    }
    se.onReplySignal.connect(onReply)
    se.concatenate("song/datail?ids="+id); // 触发网络请求
}

function getLyric(id){
        function onReply(reply){
            se.onReplySignal.disconnect(onReply)
            var lyric = JSON.parse(reply).lrc.lyric
            // console.log(lyric)
            if(lyric.length<1) return
            var lyrics = (lyric.replace(/\[.*\]/gi,"")).split("\n")
            // console.log(lyrics)
            if(lyrics.length>0) pageDetailView.lyrics = lyrics

            var times = []
            lyric.replace(/\[.*\]/gi,function(match,index){
                //match : [00:00.00]
                if(match.length>2){
                    var time  = match.substr(1,match.length-2)
                    var arr = time.split(":")
                    var timeValue = arr.length>0? parseInt(arr[0])*60*1000:0
                    arr = arr.length>1?arr[1].split("."):[0,0]
                    timeValue += arr.length>0?parseInt(arr[0])*1000:0
                    timeValue += arr.length>1?parseInt(arr[1]):0
                    times.push(timeValue)
                }
            })
              mediaplayer.times=times
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("lyric?id="+id)
    }




//头部内容
function setWindowSize(width = window.mWINDOW_WIDTH,height = window.mWINDOW_HEIGHT){
        window.width = width
        window.height = height
        window.x=(Screen.desktopAvailableWidth-window.width)/2
        window.y=(Screen.desktopAvailableHeight-window.height)/2
    }

function setPoint(mouseX =0 ,mouseY = 0){
        point =Qt.point(mouseX,mouseY)
        //console.log(mouseX,mouseY)
    }

    function moveX(mouseX = 0 ){
        var x = window.x + mouseX-point.x
        if(x<-(window.width-70)) x = - (window.width-70)
        if(x>Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
        window.x = x
    }

    function moveY(mouseY = 0 ){
        var y = window.y + mouseY-point.y
        if(y<=0) y = 0
        if(y>Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
        window.y = y
    }

//显示歌单
function showPlayList(targetId="",targetType="10"){
    repeater.itemAt(menuView.currentIndex).visible = false
    var loader = repeater.itemAt(5)
    loader.visible = true
    loader.source = qmlList[5].qml+".qml"
    loader.item.targetType=targetType
    loader.item.targetId=targetId
}

//隐藏歌单
function hidePlayList(){
    repeater.itemAt(menuView.currentIndex).visible = true
    var loader = repeater.itemAt(5)
    loader.visible = false
}
