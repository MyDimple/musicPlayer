import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
Frame{
    property var musiclist: []
    property int all: 0
    property int pageSize: 60
    property int current: 1
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
    }
    Component{
        id:listViewDelegate
        Rectangle{
            // color:"grey"
            height:45
            width: listView.width
            RowLayout{
                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text{
                    text:index+1
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
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:album
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
            }
        }

    }
    Component{
        id:listViewHeader
        Rectangle{
            color:"grey"
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
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"歌名"
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"歌手"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"专辑"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
                Text{
                    text:"操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color:"black"
                    elide:Qt.ElideRight//截断
                }
            }
        }
    }
}
