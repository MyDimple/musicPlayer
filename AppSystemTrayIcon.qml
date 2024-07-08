import Qt.labs.platform

//系统托盘
SystemTrayIcon {
    id:systemTray
    visible: true
    // icon.source: c
    icon.source:"qrc:/images/music"
    onActivated: {
        window.show()
        window.raise()
        window.requestActivate()
    }
    menu: Menu{
        id:menu
        MenuItem{
            text: "上一曲"
            onTriggered: layoutBottomView.playPrevious()
        }
        MenuItem{
            text: layoutBottomView.playingState===0?"播放":"暂停"
            onTriggered: layoutBottomView.playOrPause()
        }
        MenuItem{
            text: "下一曲"
            onTriggered: layoutBottomView.playNext()
        }
        MenuSeparator{}
        MenuItem{
            text: "显示"
            onTriggered: window.show()
        }
        MenuItem{
            text: "退出"
            onTriggered: Qt.quit()
        }
    }
}
