import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
Frame{
    property var musiclist: []
    property int all: 0
    property int pageSize: 60
    property int current: 0
    signal loadMore(int offset,int current) //加载其他页的信号

    Layout.fillHeight: true
    Layout.fillWidth: true
    clip:true
    spacing: 0
    padding: 0
    onMusiclistChanged: {
        // musiclist.length
        listViewModel.clear()
        listViewModel.append(musiclist)
    }
    background: Rectangle{
        color:"#00000000"
    }

    ListView{
        anchors.bottomMargin: 70
        id:listView
        anchors.fill: parent
        model:ListModel{
            id:listViewModel
        }
        delegate: listViewDelegate
        ScrollBar.vertical: ScrollBar{
            anchors.right: parent.right
        }
        header: listViewHeader
        highlight: Rectangle{
            color:"#f0f0f0"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
    }
    Component{
        id:listViewDelegate
        Rectangle{
             color: mouse.hovered ? "#f0f0f0" : "#00000000"

            height:45
            width: listView.width

            Shape{
                anchors.fill: parent
                ShapePath{
                    strokeWidth: 0
                    strokeColor: "#50000000"
                    strokeStyle: ShapePath.SolidLine
                    startX: 0
                    startY: 45
                    PathLine{
                        x:0
                        y:45
                    }
                    PathLine{
                        x:parent.width
                        y:45
                    }
                }
            }

            RowLayout{
                id:item
                TapHandler{
                    onTapped: listView.currentIndex=index
                }
                //取代了MouseArea的作用
                HoverHandler {
                    id: mouse
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }

                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text{
                    text:index+1+pageSize*current//解决其他分页的序号相同的问题
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:name
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:artist
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideMiddle//截断
                }
                Text{
                    text:album
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideMiddle//截断
                }
                Item{
                    Layout.preferredWidth: parent.width*0.15
                    RowLayout{
                        anchors.centerIn: parent
                        MusicIconButton{
                            iconSource: "qrc:/images/pause"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "播放"
                            onClicked: {
                                _layoutBottomView.playList=musiclist
                                _layoutBottomView.playMusic(index)
                            }
                        }
                        MusicIconButton{
                            iconSource: "qrc:/images/favorite"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "喜欢"
                            onClicked: {

                            }
                        }
                        MusicIconButton{
                            iconSource: "qrc:/images/clear"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "删除"
                            onClicked: {

                            }
                        }
                    }
                }

            }

        }
    }
    Component{
        id:listViewHeader
        Rectangle{
            color:"#00AAAA"
            height:45
            width: listView.width
            RowLayout{
                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text{
                    text:"序号"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"white"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"歌名"
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"white"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"歌手"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"white"
                    elide:Qt.ElideMiddle//截断
                }
                Text{
                    text:"专辑"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"white"
                    elide:Qt.ElideMiddle//截断
                }
                Text{
                    text:"操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"white"
                    elide:Qt.ElideRight//截断
                }
            }
        }
    }

    //分页
    Item{
        id:pageButton
        visible: musiclist.length!==0
        width: parent.width
        height: 40
        anchors.top:listView.bottom
        anchors.topMargin: 20
        ButtonGroup{//该组件的作用，比如一堆按钮只能选中一个
            buttons:buttons.children
        }
        RowLayout{
            id:buttons
            anchors.centerIn: parent
            Repeater{

                id:repeater
                model:all/pageSize>9?9:all/pageSize
                Button{
                    Text{
                        anchors.centerIn: parent
                        text:modelData+1//索引
                        font.family:"微软雅黑"
                        font.pointSize: 14
                        color: checked?"#497563":"black"
                    }
                    background: Rectangle{
                        implicitHeight: 30
                        implicitWidth: 30
                        color: checked?"#e2f0f8":"#20e9f4ff"
                        radius: 3
                    }
                    checkable: true
                    checked: modelData===current
                    onClicked: {
                        if(current===index)
                        {
                            return
                        }
                        current=index
                        loadMore(current*pageSize,index)
                    }
                }
            }
        }
    }





}
