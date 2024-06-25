//PageHomeView.qml

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

RowLayout{
    spacing: 0

    property int defaultIndex: 0

    property var qmlList: [
        {icon:"recommend-white",value:"推荐内容",qml:"DetailRecommendPageView",menu:true},
        {icon:"cloud-white",value:"搜索音乐",qml:"DetailSearchPageView",menu:true},
        {icon:"local-white",value:"本地音乐",qml:"DetailLocalPageView",menu:true},
        {icon:"history-white",value:"播放历史",qml:"DetailHistoryPageView",menu:true},
        {icon:"favorite-big-white",value:"我喜欢的",qml:"DetailFavoritePageView",menu:true},
        {icon:"",value:"",qml:"DetailPlayListPageView",menu:false},

    ]

//左边菜单
Frame{
    Layout.preferredWidth: 200
    Layout.fillHeight: true
    background: Rectangle{//菜单栏背景
        color: "#AA00AAAA"
    }

    padding: 0

    ColumnLayout{
        anchors.fill: parent
        //占位item
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            //中间左上方自定义图片
            MusicBorderImage{
                anchors.centerIn:parent
                height: 100
                width:100
                borderRadius: 100
            }
        }

        //菜单栏
        ListView{
            id:menuView
            height: parent.height
            Layout.fillHeight: true
            Layout.fillWidth: true
            model:ListModel{
                id:menuViewModel
            }
            delegate:menuViewDelegate
            highlight: Rectangle{//点击后的高亮效果
                color: "#aa73a7ab"
            }
            highlightMoveDuration: 100

        }
    }

    Component{
        id:menuViewDelegate
        Rectangle{
            id:menuViewDelegateItem
            height: 50
            width: 200
            color: "#AA00AAAA" //左边菜单默认颜色
            RowLayout{
                anchors.fill: parent
                anchors.centerIn: parent
                spacing:15
                Item{
                    width: 30
                }

                Image{
                    source: "qrc:/images/"+icon
                    Layout.preferredHeight: 20
                    Layout.preferredWidth: 20
                }

                Text{
                    text:value
                    Layout.fillWidth: true
                    height:50
                    font.family:"微软雅黑"
                    font.pointSize: 12
                    color: "#ffffff"
                }
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {//鼠标进入的颜色
                    color="#aa73a7ab"
                }
                onExited: {//鼠标离开后的颜色
                    color="#AA00AAAA"
                }
                onClicked:{//切换功能
                    hidePlayList()
                    repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex).visible = false //将原本索引的内容不可视
                    menuViewDelegateItem.ListView.view.currentIndex = index //设置当前索引
                    var loader = repeater.itemAt(index) //获取当前索引的loader
                    loader.visible = true //让其可视
                    loader.source = qmlList[index].qml + ".qml"

                }
            }
        }
    }

    Component.onCompleted: {
        menuViewModel.append(qmlList.filter(item=>item.menu)) //增加过滤器，隐藏歌单不在左边菜单栏显示

        //加载完成后的默认页面
        var loader = repeater.itemAt(defaultIndex) //获取第一个loader
        loader.visible = true //让其可视
        loader.source = qmlList[defaultIndex].qml + ".qml"

        menuView.currentIndex=defaultIndex
    }
}

    Repeater{//重复构造子组件
        id:repeater
        model: qmlList.length
        Loader{//加载页面
            visible:false //默认都不显示
            Layout.fillHeight: true
            Layout.fillWidth: true

        }
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

}
