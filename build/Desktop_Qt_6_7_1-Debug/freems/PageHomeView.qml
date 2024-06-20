//PageHomeView.qml

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.12

//中间窗口
Frame{

    property var qmlList: [
        {icon:"recommend-white",value:"推荐内容",qml:"DetailRecommendPageView"},
        {icon:"cloud-white",value:"搜索音乐",qml:"DetailSearchPageView"},
        {icon:"local-white",value:"本地音乐",qml:"DetailLocalPageView"},
        {icon:"history-white",value:"播放历史",qml:"DetailHistoryPageView"},
        {icon:"favorite-big-white",value:"我喜欢的",qml:"DetailFavoritePageView"},
        {icon:"favorite-big-white",value:"专辑歌单",qml:"DetailPlayListPageView"}
    ]

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
    }
}
