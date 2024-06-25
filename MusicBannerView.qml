
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml 2.12

//推荐内容轮播图效果
Frame{
    property int current: 0
    property alias bannerList : bannerView.model
     background: Rectangle{
        color: "#00000000"
    }

     //与listView类似，这是以路径的形式
    PathView{
        id:bannerView
        width: parent.width
        height: parent.height

        clip: true //超出区域裁剪

        //控制定时器的开关时机
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor //光标变化
            onEntered: {
                bannerTimer.stop()
            }
            onExited: {
                bannerTimer.start()
            }
        }


        delegate: Item{
            id:delegateItem
            width:bannerView.width*0.7
            height: bannerView.height
            z:PathView.z?PathView.z:0
            scale: PathView.scale?PathView.scale:1.0

            MusicRoundImage{
                id:image
                imgSrc:modelData.imageUrl //pathView的modeData
                width: delegateItem.width
                height: delegateItem.height
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                        if(bannerView.currentIndex === index){
                            var item  =bannerView.model[index]
                            var targetId = item.targetId+""
                            var targetType = item.targetType+"" //1:单曲,10:专辑,1000:歌单
                            switch(targetType){
                            case "1":
                                //播放歌曲
                                layoutBottomView.current=-1
                                layoutBottomView.playList=[{id:targetId,name:"",artist:"",cover:"",album:""
                                                           }]
                                layoutBottomView.current=0
                                break
                            case "10":
                                //打开专辑
                            case "1000":
                                //打开播放列表
                                pageHomeView.showPlayList(targetId,targetType)
                                break
                            }

                        }else{
                            bannerView.currentIndex = index
                        }

                }
            }

        }

        pathItemCount: 3 //当前展示有几个item
        path:bannerPath

        //强调中间元素
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }


    Path{
        id:bannerPath
        startX: 0
        startY:bannerView.height/2-10

        //实现z从0到2再到0,尺寸从0.6到0.85到0.6的一个变化过程
        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}

        PathLine{
            x:bannerView.width/2
            y:bannerView.height/2-10
        }

        PathAttribute{name:"z";value:2}
        PathAttribute{name:"scale";value:0.85}

        PathLine{
            x:bannerView.width
            y:bannerView.height/2-10
        }

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}
    }

    //轮播图底部切换点
    PageIndicator{
        id:indicator
        anchors{
            top:bannerView.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -10
        }
        count: bannerView.count
        currentIndex: bannerView.currentIndex
        spacing: 10
        delegate: Rectangle{
            width: 20
            height: 5
            radius: 5
            color: index===bannerView.currentIndex?"balck":"gray"
            Behavior on color{
                ColorAnimation {
                    duration: 200
                }
            }

            //鼠标进入底部切换点自动切换
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    bannerTimer.stop()
                    bannerView.currentIndex = index
                }
                onExited: {
                    bannerTimer.start()
                }
            }
        }
    }

    //定时器实现自动切换
    Timer{
        id:bannerTimer
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            if(bannerView.count>0)
                bannerView.currentIndex=(bannerView.currentIndex+1)%bannerView.count
        }
    }
}
