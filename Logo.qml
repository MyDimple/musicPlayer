import QtQuick

Rectangle {
    id: logo

    color: "transparent" // 设置背景色为透明

    Text {
        text: "My Logo"
        font.bold: true
        font.pixelSize: 24
        color: "black"
        anchors.centerIn: parent // 将文本居中
    }

    // TapHandler
}
