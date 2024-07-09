import QtQuick 2.15
import QtQuick.Layouts
import "freems.js" as Control
Rectangle {
    property alias lyrics: list.model
    property alias current: list.currentIndex
    property bool flag: true
    id:lyricView
    Layout.preferredHeight: parent.height*0.8
    Layout.alignment: Qt.AlignHCenter
    clip:true
    color:"#00000000"
    ListView{
        id:list
        // width: 2
        anchors.fill:parent
        model: ["没有歌词","歌词","歌词"]
        delegate: listDelegate
        highlight: Rectangle{
           // color:"#1000AAAA"
            color:"#b4b2b2"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0

        currentIndex: 0
        // 让歌词高亮置于中间
        preferredHighlightBegin: parent.height/2-50
        preferredHighlightEnd: parent.height/2
        highlightRangeMode: ListView.StrictlyEnforceRange

    }

    Component{
        id:listDelegate

        Item{
            id:delegateItem
            width:parent.width
            // Component.onCompleted: width=parent.width
            height:50
            Text{
                text:modelData
                anchors.centerIn: parent
                color:index===list.currentIndex?"#black":"#grey"
                font.family: "微软雅黑"
                font.pointSize: 12

            }
            states:State{
                when:delegateItem.ListView.isCurrentItem
                PropertyChanges{
                    target: delegateItem
                    scale:1.4
                    // color:"red"
                }
            }


            TapHandler {
                onTapped: {
                    // 设置MediaPlayer的position到对应歌词的时间戳
                    if (index >= 0 && index < mediaplayer.times.length) {
                        var time = mediaplayer.times[index];
                        mediaplayer.position = time;
                        // 更新进度条
                        Control.setSlider(0, mediaplayer.duration, time);

                    }
                }
            }

        }
    }
}
