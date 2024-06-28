import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import QtQml

RowLayout{
    Layout.fillHeight: true;
    spacing: 0

    property int defaultIndex: 0

    // left navigation
    Rectangle{
        id: _left
        Layout.fillHeight: true;
        width:200;
        property var qmlList: [
            {value:"推荐内容", qml: "ContentRecommendPage.qml", menu: true},
            {value:"本地音乐", qml: "ContentLocalPage.qml", menu: true},
            {value:"播放历史", qml: "ContentHistoryPage.qml", menu: true},
            {value:"我喜欢的", qml: "ContentFavoratePage.qml", menu: true},
            {value:"搜索音乐", qml: "ContentSearchPage.qml", menu: false},
            {value:"歌词", qml: "ContentPlayListPage.qml", menu: false}
        ]
        ColumnLayout{
            id: _navigation

            anchors.fill: parent

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
                    id: _models
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
                        id: _handler
                        onTapped: {
                            // 隐藏上次选择页面
                            _repeater.itemAt(_list.currentIndex).visible = false
                            _list.currentIndex = index
                            var loader = _repeater.itemAt(index)
                            loader.visible = true
                            // 加载该页面
                            loader.source = _left.qmlList[index].qml
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
                // use filter
                _models.append(_left.qmlList.filter(item=>item.menu))
                //加载完成后的默认页面
                var loader = _repeater.itemAt(defaultIndex) //获取第一个loader
                loader.visible = true //让其可视
                loader.source = _left.qmlList[defaultIndex].qml
                _list.currentIndex = defaultIndex
            }
        }
    }

    // content
    Rectangle{
        Layout.fillHeight: true;
        Layout.fillWidth: true;
        border.color: "black";
        radius: 10
        border.width: 1
        Repeater{
            id:_repeater
            model: _left.qmlList.length
            Loader{ //加载页面
                visible:false   //默认都不显示
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
