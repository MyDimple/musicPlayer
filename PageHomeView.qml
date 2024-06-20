//PageHomeView.qml

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

RowLayout{
    property var qmlList: [
        {icon:"recommend-white",value:"推荐内容",qml:"DetailRecommendPageView"},
        {icon:"cloud-white",value:"搜索音乐",qml:"DetailSearchPageView"},
        {icon:"local-white",value:"本地音乐",qml:"DetailLocalPageView"},
        {icon:"history-white",value:"播放历史",qml:"DetailHistoryPageView"},
        {icon:"favorite-big-white",value:"我喜欢的",qml:"DetailFavoritePageView"},
    ]
//左边菜单
Frame{
    Layout.preferredWidth: 200
    Layout.fillHeight: true
    background: Rectangle{
        color: "#00000000"
    }

    padding: 0

    ColumnLayout{
        anchors.fill: parent
        //占位item
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            //中间左上方自定义图片
            // MusicRoundImage{
            //     anchors.centerIn:parent
            //     height: 100
            //     width:100
            //     borderRadius: 100
            // }
        }

        ListView{
            id:menuView
            height: parent.height
            Layout.fillHeight: true
            Layout.fillWidth: true
            model:ListModel{
                id:menuViewModel
            }
            delegate:menuViewDelegate
        }
    }

    Component{
        id:menuViewDelegate
        Rectangle{
            id:menuViewDelegateItem
            height: 50
            width: 200
            color: "#00AAAA"
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
                onEntered: {
                    color="#aa73a7ab"
                }
                onExited: {
                    color="#00AAAA"
                }
            }
        }
    }

    Component.onCompleted: {
        menuViewModel.append(qmlList)
        var loader = repeater.itemAt(0) //获取第一个loader
        loader.visible = true //让其可视
        loader.source = qmlList[0].qml + ".qml"
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
}
