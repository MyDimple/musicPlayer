import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 1100
    height: 700
    visible: true
    // flags:Qt.FramelessWindowHint

    title:"music player"

    ColumnLayout{
        anchors.fill:parent;
        spacing: 0

        // 头部视图组件
        LayoutHead{
            id: _head
        }

        // 中部视图组件
        PageHome{
            id: _home
        }

        // 底部视图组件
        LayoutBottom{
            id: _bottom
        }


    }

}
