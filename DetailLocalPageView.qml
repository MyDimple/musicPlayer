import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Qt.labs.platform
import QtCore
import QtQml 2.12
import se.qt.music


//本地音乐布局
ColumnLayout{

    //设置本地音乐保存路径
    Settings{
        id:localSettings
        location : "conf/local.ini"
    }

    Rectangle{

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("本地音乐")
            font.family: "微软雅黑"
            font.pointSize: 25
            color: "white"

        }
    }

    RowLayout{
        height: 80
        Item{
            width: 5
        }

        MusicTextButton{
            btnText: "添加本地音乐"
            btnHeight: 50
            btnWidth: 200
            onClicked: fileDialog.open()
        }
        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                getLocal()

            }
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                saveLocal()
            }
        }

    }

    MusicListView{
        id:localListView
        onDeleteItem: deleteLocal(index) //对删除信号的处理
    }

    Component.onCompleted: {
        getLocal() //构建完成先获取本地歌曲 有点问题获取不了
    }

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

    //文件对话框
    FileDialog{
            id:fileDialog
            fileMode: FileDialog.OpenFiles
            nameFilters: ["MP3 Music Files(*.mp3)","FLAC MUsic Files(*.flac)"]
            //folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0] //不设置这个便会打开系统默认存放音频文件的文件夹
            acceptLabel: "确定"
            rejectLabel: "取消"

            onAccepted: {
                //获取音乐文件逻辑
                var list =getLocal()
                for(var index in files){
                    var path = files[index].toString()
                    console.log(path)
                    var lyricsFilePath = path.replace(/\.[^\.]+$/, ".lrc");//本地歌曲文件
                    var lyric=se.readFileContent(lyricsFilePath)
                    locallyc(lyric)
                    var arr = path.split("/")
                    var fileNameArr = arr[arr.length-1].split(".")
                    //去掉后缀
                    fileNameArr.pop()
                    var fileName = fileNameArr.join(".")
                    //歌手-名称.mp3
                    var nameArr = fileName.split("-")
                    var name = ""
                    var artist = ""
                    if(nameArr.length>1){
                        artist = nameArr[0]
                        nameArr.shift()
                    }
                    name = nameArr.join("-")
                     // if(list.filter(item=>item.id === path).length<1)
                    list.push({
                                  id:path+"",
                                  name,artist,
                                  url:path+"",
                                  album:"本地音乐",
                                  type:"1"//1表示本地音乐，0表示网络
                              })
                    saveLocal(list)
                     // localListView.musiclist  = list
                }
            }
        }
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
}
