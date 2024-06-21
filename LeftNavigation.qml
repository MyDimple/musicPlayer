import QtQuick
import QtQuick.Layouts

Rectangle {
    ColumnLayout{
        anchors.fill: parent

        property var qmlList: [
            {value:"推荐内容"},
            {value:"搜索音乐"},
            {value:"本地音乐"},
            {value:"播放历史"},
            {value:"我喜欢的"},
            {value:"专辑歌单"}
        ]

        // placeholder
        Item{
            Layout.fillWidth: true
            height: 140
        }

        ListView{
            id: _list
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: ListModel{
                id: _navigation
            }
            delegate: _delegateItem
            spacing: 5
        }
        Component{
            id:_delegateItem
            Rectangle{
                height: 50
                width: 200
                radius: 10
                border.color: "black"
                border.width: 1
                RowLayout{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing:15
                    Item{
                        width: 30
                    }

                    Image{
                        // source: "qrc:/images/"+icon
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }

                    Text{
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family:"微软雅黑"
                        font.pointSize: 12
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        color="grey"
                    }
                    onExited: {
                        color="#ffffff"
                    }
                }
            }
        }
        Component.onCompleted: {
            _navigation.append(qmlList)
        }
    }



}
