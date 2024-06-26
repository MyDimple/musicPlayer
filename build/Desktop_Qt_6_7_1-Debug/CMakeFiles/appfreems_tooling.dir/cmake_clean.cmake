file(REMOVE_RECURSE
  "se/qt/music/Background.qml"
  "se/qt/music/DetailFavoritePageView.qml"
  "se/qt/music/DetailHistoryPageView.qml"
  "se/qt/music/DetailLocalPageView.qml"
  "se/qt/music/DetailPlayListPageView.qml"
  "se/qt/music/DetailRecommendPageView.qml"
  "se/qt/music/DetailSearchPageView.qml"
  "se/qt/music/HotMusic.qml"
  "se/qt/music/LayoutBottomView.qml"
  "se/qt/music/LayoutHeaderView.qml"
  "se/qt/music/Main.qml"
  "se/qt/music/MusicBannerView.qml"
  "se/qt/music/MusicBorderImage.qml"
  "se/qt/music/MusicIconButton.qml"
  "se/qt/music/MusicListView.qml"
  "se/qt/music/MusicLyricView.qml"
  "se/qt/music/MusicRoundImage.qml"
  "se/qt/music/MusicTextButton.qml"
  "se/qt/music/MusicToolButton.qml"
  "se/qt/music/PageDetailView.qml"
  "se/qt/music/PageHomeView.qml"
  "se/qt/music/images.qrc"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appfreems_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
