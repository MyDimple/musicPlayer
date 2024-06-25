import QtQuick
import QtQuick.Layouts

Rectangle {
    ColumnLayout{
        anchors.fill: parent

        property var qmlList: [
            {value:"推荐内容"},
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
            currentIndex: -1
            // 禁止滑动
            interactive: false
        }
        Component{
            id:_delegateItem
            Rectangle{
                height: 50
                width: 200
                radius: 10
                border.color: "black"
                border.width: 1
                color: _list.currentIndex === index ? "grey":"#ffffff"
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
                        id: _text
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family:"微软雅黑"
                        font.pointSize: 12
                        color: {
                            if(_list.currentIndex === index)
                                return "black"
                            _mouse.hovered ? "black":"grey"
                        }

                    }
                }
                TapHandler{
                    onTapped: {
                        _list.currentIndex = index
                    }
                }
                HoverHandler {
                    id: _mouse
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
        Component.onCompleted: {
            _navigation.append(qmlList)
        }
    }
}
