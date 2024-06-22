import QtQuick 2.12
import QtQuick.Controls 2.5

//自定义圆角图片
item {
    property string imgSrc: "qrc:/images/player"
    property int borderRadius: 5

    image{
        anchors.centerIn:parent
        source:imgSrc
        smooth: true
        width:parent.width
        height:parent.height
        fillMode:Image.PreserveAspectCrop //保持比例裁剪
        antialiasing:true //抗锯齿
    }

}
