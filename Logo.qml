import QtQuick

Rectangle {
    id: logo

    // color: "#f5f8f5"

    radius: 5
    border.color: "black"
    border.width: 1
    Text {
        text: "FreeMsp"
        font.bold: true
        font.pixelSize: 24
        font.family: "宋体"
        color: "black"
        anchors.centerIn: parent // 将文本居中
    }

    // TapHandler
}
