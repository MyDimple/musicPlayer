import QtQuick 2.15
import QtQuick.Layouts
Rectangle {
    property alias lyrics: list.model
    property alias current: list.currentIndex
    property bool flag: true
    id:lyricView
    Layout.preferredHeight: parent.height*0.8
    Layout.alignment: Qt.AlignHCenter
    clip:true

    ListView{
        id:list
        // width: 2
        anchors.fill:parent
        model: ["没有歌词","歌词","歌词"]
        delegate: listDelegate
        highlight: Rectangle{
            color:"#2073a7db"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0

        currentIndex: 0
        // 让歌词高亮置于中间
        preferredHighlightBegin: parent.height/2-50
        preferredHighlightEnd: parent.height/2
        highlightRangeMode: ListView.StrictlyEnforceRange
        // MouseArea {
        //               anchors.fill: parent
        //               onClicked: {
        //                   // 获取当前歌词行的时间戳
        //                   console.log( list.currentIndex)
        //                   var timeIndex = list.currentIndex
        //                   var timeValue = mediaplayer.times[timeIndex]

        //                   // 设置音乐播放器的播放位置
        //                   if (timeValue !== undefined) {
        //                       mediaplayer.position = timeValue
        //                       layoutBottomView.setSlider(0,mediaplayer.duration,mediaplayer.position)
        //                   }
        //               }
        //           }

        // onCurrentIndexChanged: {
        //        if (currentIndex >= 0 && currentIndex < mediaplayer.times.length) {
        //            var time = mediaplayer.times[currentIndex];
        //            mediaplayer.position = time;
        //            layoutBottomView.setSlider(0, mediaplayer.duration, time);
        //        }
        //    }
    }

    Component{
        id:listDelegate

        Item{
            id:delegateItem
            width:parent.width

            height:50
            Text{
                text:modelData
                anchors.centerIn: parent
                color:index===list.currentIndex?"black":"grey"
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
                        layoutBottomView.setSlider(0, mediaplayer.duration, time);

                    }
                }
            }

        }
    }
}
