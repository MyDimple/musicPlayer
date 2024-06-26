// #include "localmusicmanager.h"

// LocalMusicManager::LocalMusicManager(QObject *parent)
//     : QObject(parent)
//     , m_settings("conf/local.ini", QSettings::IniFormat)
// {
//     m_settings.beginGroup("local");
// }

// void LocalMusicManager::loadLocalMusic()
// {
//     if (m_settings.contains("musicList")) {
//         QByteArray musicListData = m_settings.value("musicList").toByteArray();
//         QJsonDocument doc = QJsonDocument::fromJson(musicListData);
//         m_musicList = doc.array();
//     }
// }

// void LocalMusicManager::saveLocalMusic(const QJsonArray &musicList)
// {
//     QJsonDocument doc(musicList);
//     QByteArray musicListData = doc.toJson(QJsonDocument::Compact);
//     m_settings.setValue("musicList", musicListData);
//     m_musicList = musicList;
// }
