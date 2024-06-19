import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow {
    width: 1200
    height: 800
    visible: true
    color:"white"
    //布局
    ColumnLayout{
        anchors.fill: parent
        spacing: 0

    //上部模块
    LayoutHeaderView{
        id:_layoutHeaderView
        }

    //中部模块
    PageHomeView{
        id:_pageHomeView
        }

    //底部模块
    LayoutBottomView{
        id:_layoutBottomView
        }
    }
}

