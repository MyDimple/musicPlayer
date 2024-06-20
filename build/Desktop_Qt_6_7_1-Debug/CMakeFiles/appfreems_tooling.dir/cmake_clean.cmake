file(REMOVE_RECURSE
  "freems/DetailFavoratePageView.qml"
  "freems/DetailHistoryPageView.qml"
  "freems/DetailLocalPageView.qml"
  "freems/DetailRecommendPageView.qml"
  "freems/DetailSearchPageView.qml"
  "freems/LayoutBottomView.qml"
  "freems/LayoutHeaderView.qml"
  "freems/Main.qml"
  "freems/MusicIconButton.qml"
  "freems/MusicToolButton.qml"
  "freems/PageHomeView.qml"
  "freems/images.qrc"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appfreems_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
