
import QtQuick
import QtQuick.Controls
import QtQml

//精品歌单布局
Item{

    property alias list: gridRepeater.model //暴露出model,在DetailRecommendPageView.qml中的getHotMusic()方法中获取model

    Grid{//网格
        id:gridLayout
        anchors.fill:parent
        columns: 5 //每行5个歌单
        Repeater{
            id:gridRepeater
            Frame{
                padding: 5
                width: parent.width*0.2
                height: parent.width*0.2+30
                background: Rectangle{
                    id:background
                    color: "#00000000"
                }
                clip: true

                MusicRoundImage{
                    id:img
                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.coverImgUrl //在modelData中获取图片资源

                }

                Text{//图片下方文字
                    anchors{
                        top:img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text:modelData.name
                    font.family: "微软雅黑"
                    height:30
                    elide: Qt.ElideMiddle //居中
                }


                //鼠标效果
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        background.color = "#50000000"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                    onClicked: {
                        var item  =gridRepeater.model[index]
                        _pageHomeView.showPlayList(item.id,"1000")
                    }

                }
            }
        }
    }
}
