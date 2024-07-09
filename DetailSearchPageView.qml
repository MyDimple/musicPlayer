import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import se.qt.music
import "freems.js" as Control
//搜索页面
ColumnLayout{
    Layout.fillWidth: true
    Layout.fillHeight: true

    spacing: 0

    Rectangle{
        Layout.fillWidth: true
        width:parent.width
        height:60
        color:"#ffffff"
        Text{
            x:10
            verticalAlignment: Text.AlignBottom
            text:qsTr("搜索音乐")
            font.family: "宋体"
            font.pointSize: 25
            color: "black"
        }
    }

    //搜索框
    Rectangle{
        Layout.fillWidth: true
        height: 80
        color: "#ffffff"

        RowLayout{
            // anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: true
            TextField{
                id:searchInput
                font.family: "微软雅黑"
                font.pointSize: 14
                selectByMouse: true
                selectionColor: "#999999"
                placeholderText: qsTr("输入搜索内容")
                placeholderTextColor:"grey"//不同的主题颜色可能会导致提示字的默认颜色不同，根据需要修改
                color: "grey"
                background: Rectangle{
                    color:"#00000000"

                    //边框
                    border.width: 1
                    border.color: "black"
                    radius: 5
                    opacity: 0.5
                    implicitHeight: 40
                    implicitWidth: 400
                }
                focus:true
                Keys.onPressed: {
                            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                                Control.doSearch();
                            }
                        }

            }
            MusicIconButton{
                iconSource: "qrc:/icons/sousuo.png"
                toolTip:"搜索"
                onClicked:Control.doSearch()
            }
        }
    }

    MusicListView{
        id:musiclistView
        onLoadMore:Control.doSearch(offset,current)
        // Layout.topMargin: 10

    }

    Search{
        id:se
    }


}

