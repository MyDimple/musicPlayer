import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import se.qt.music

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
                                doSearch();
                            }
                        }

            }
            MusicIconButton{
                iconSource: "qrc:/icons/sousuo.png"
                toolTip:"搜索"
                onClicked:doSearch()
            }
        }
    }

    MusicListView{
        id:musiclistView
        onLoadMore:doSearch(offset,current)
        // Layout.topMargin: 10

    }

    Search{
        id:se
    }

    function doSearch(offset=0,current=0)
    {
        // console.log(offset)
        var keywords=searchInput.text
        if(keywords.length<1){
            return
        }

        function onReply(reply) {

            se.onReplySignal.disconnect(onReply)
            // console.log(reply);
            var result = JSON.parse(reply).result//获取并解析数据
            var songs = result.songs
            musiclistView.current=current
            musiclistView.all=result.songCount
            musiclistView.musiclist=songs.map(item=>{
                                                  return{
                                                      id:item.id,
                                                      name:item.name,
                                                      artist:item.artists[0].name,
                                                      album:item.album.name,
                                                      cover:""
                                                  }
                                              })
        }
        se.onReplySignal.connect(onReply)
        se.concatenate("search?keywords="+keywords+"&offset="+offset+"&limit=60"); // 触发网络请求
    }
}

