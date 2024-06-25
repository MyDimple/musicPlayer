import QtQuick 2.15
import QtQuick.Layouts
Rectangle {
    property alias lyrics: list.model
    property alias current: list.currentIndex
    id:lyric
    Layout.preferredHeight: parent.height*0.8
    Layout.alignment: Qt.AlignHCenter
    clip:true

    ListView{
        id:list
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
                font:{
                    family: "微软雅黑"
                    pointSize: 12
                }
            }
            states:State{
                when:delegateItem.ListView.isCurrentItem
                PropertyChanges{
                    target: delegateItem
                    scale:1.2
                }
            }
            TapHandler{
                // anchors.fill: parent
                onCanceled: list.currentIndex=index
            }
        }
    }
}
