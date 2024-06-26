import QtQuick 2.12
import Qt5Compat.GraphicalEffects

//全局背景
Rectangle{

    property bool showDefaultBackground: true
    Image {
        id: backgroundImage
        source: showDefaultBackground?"qrc:/images/back":layoutBottomView.musicCover
        anchors.fill:parent
        fillMode: Image.PreserveAspectCrop
    }

    ColorOverlay{
        id:backgroundImageOverlay
        anchors.fill:backgroundImage
        source: backgroundImage
        color: "#55000000"
    }

    FastBlur{
        anchors.fill: backgroundImageOverlay
        source: backgroundImageOverlay
        radius: 80
    }
}
