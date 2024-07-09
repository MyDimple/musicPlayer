//PageDetailView.qml

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.12

//歌曲详情
Rectangle {
    property alias lyrics:lyricView.lyrics
    property alias current:lyricView.current
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "white"

    RowLayout{
        anchors.fill: parent
        Frame{
            Layout.preferredWidth: parent.width*0.45
            Layout.fillHeight: true
             Layout.fillWidth: true
            background: Rectangle{
                radius: 10
                border.width: 1
                border.color: "black"
                color: "#00000000"
            }

            Text {
                id: name
                text: layoutBottomView.musicName
                anchors{
                    bottom: artist.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: "微软雅黑"
                    pointSize: 16
                }
                color: "grey"
                // color: "#aaffffff"
            }

            Text {
                id: artist
                text: layoutBottomView.artistName
                anchors{
                    bottom: cover.top
                    bottomMargin: 50
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family:"微软雅黑"
                    pointSize: 12
                }
                color: "grey"
                // color: "#aaffffff"
            }

            Text {
                id: lyric
                /////
                visible: _layoutHeaderView.isSmallWindow
                /////
                text: lyricView.lyrics[lyricView.current]?lyricView.lyrics[lyricView.current]:"暂无歌词"
                anchors{
                    top: cover.bottom
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: "微软雅黑"
                    pointSize: 12
                }
                // color: "#aaffffff"
                color: "grey"
            }

            MusicBorderImage{
                id:cover
                anchors.centerIn: parent
                width: parent.width*0.6
                height: width
                borderRadius: width
                imgSrc: layoutBottomView.musicCover
                isRotating:  layoutBottomView.playingState===1
            }
        }

        Frame{
            visible: !_layoutHeaderView.isSmallWindow
            Layout.preferredWidth: parent.width*0.55
            Layout.fillHeight: true
            background: Rectangle{
                radius: 10
                border.width: 1
                border.color: "black"
                color: "#00000000"
            }
            MusicLyricView{
                id:lyricView
                anchors.fill: parent

            }
        }

    }
}
