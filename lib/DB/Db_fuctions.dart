import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

List<Audio> audioList = [];
AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
bool notification = true;
audioConverter(List<AllSongModel> songs, int index) async {
  audioList.clear();
  assetsAudioPlayer.stop();

  for (int i = 0; i < songs.length; i++) {
    audioList.add(
      Audio.file(
        songs[i].uri!,
        metas: Metas(
          title: songs[i].name,
          artist: songs[i].artist,
          id: songs[i].id.toString(),
        ),
      ),
    );
  }
  await assetsAudioPlayer.open(
    Playlist(audios: audioList, startIndex: index),
    showNotification: notification,
    notificationSettings: const NotificationSettings(
      stopEnabled: false,
    ),
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
  );
  assetsAudioPlayer.setLoopMode(LoopMode.playlist);
}

findCurrentSong(int playingId) {
  for (var element in allSongs) {
    if (element.id == playingId) {
      currentPlayingsong = element;
      break;
    }
  }
}

AllSongModel? currentPlayingsong;

void addToDb({required List<AllSongModel> songs}) async {
  final musicDb = await Hive.openBox('songs_db');
  int id = 0;

  if (musicDb.length < 1) {
    for (AllSongModel s in songs) {
      musicDb.add(AllSongModel(
          name: s.name,
          artist: s.artist,
          uri: s.uri,
          duration: s.duration,
          id: id));
    }
    id++;
  }

  getSongs();
}

Future<List<AllSongModel>> getSongs() async {
  final musicDb = await Hive.openBox('songs_db');
  List<AllSongModel> songs = [];
  if (songs.length < 1) {
    for (AllSongModel s in musicDb.values) {
      // print('this is form db ${s.title}');
      songs.add(s);
    }
  }

  // for (SongsModel s in songs) {
  //   print('this is form songs${s.title}');
  // }
  return songs;
}

// Favorites screen
ValueNotifier<List<AllSongModel>> fav = ValueNotifier([]);

addToFavorites(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.put(id, FavoriteModel(id: id));
  for (var elements in allSongs) {
    if (elements.id == id) {
      fav.value.add(elements);
    }
  }
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.delete(id);
  for (var element in allSongs) {
    if (element.id == id) {
      fav.value.remove(element);
    }
  }

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  fav.notifyListeners();
}

bool favoriteChecking(int data) {
  for (var element in fav.value) {
    if (data == element.id) {
      return true;
    }
  }
  return false;
}

//RecentPlay Screen
ValueNotifier<List<AllSongModel>> recentList = ValueNotifier([]);

recentadd(AllSongModel song) async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentList.value.contains(song)) {
    recentList.value.remove(song);
    recentList.value.insert(0, song);
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id as int);
      }
    }
  } else {
    recentList.value.insert(0, song);
    recentDb.add(song.id as int);
  }
  if (recentList.value.length > 10) {
    recentList.value = recentList.value.sublist(0, 10);
    recentDb.deleteAt(0);
  }
}
//PlayList

ValueNotifier<List<PlayListModel>> playlistnotifier = ValueNotifier([]);
void createNewPlaylist(String name) {
  bool check = false;
  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
      check = true;
    }
  }
  if (check == false) {
    PlayListModel item = PlayListModel(playListName: name);
    addPlaylistItemToDB(item);
  }
}

//addToPlaylist
void addPlaylistItemToDB(PlayListModel item) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  playlistDB.add(item);
  retrieveAllPlaylists();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

//getPlaylist
Future<void> retrieveAllPlaylists() async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  playlistnotifier.value.clear();
  playlistnotifier.value.addAll(playlistDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void deletePlaylistByIndex(int index) async {
  String? playlistName = playlistnotifier.value[index].playListName;
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  for (PlayListModel elements in playlistDB.values) {
    if (elements.playListName == playlistName) {
      var key = elements.key;
      playlistDB.delete(key);
    }
  }
  playlistnotifier.value.removeAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

Future<void> renamePlaylistByIndex(int index, String newname) async {
  String? playListname = playlistnotifier.value[index].playListName;
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  for (PlayListModel element in playListDB.values) {
    if (element.playListName == playListname) {
      var key = element.key;
      element.playListName = newname;
      playListDB.put(key, element);
    }
  }
  playlistnotifier.value[index].playListName = newname;
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void addSongToPlaylistAndShowSnackbar(
    AllSongModel song, String name, BuildContext context) {
  // ignore: unused_local_variable
  int indx = 0;
  bool check = false;
  List<AllSongModel> forThisPlayList = [];

  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
      forThisPlayList = element.playlist ?? forThisPlayList;
      break;
    }
    indx++;
  }

  for (var element in forThisPlayList) {
    if (element.id == song.id) {
      check = true;
      break;
    }
  }

  if (check == false) {
    forThisPlayList.add(song);
    PlayListModel thisPlaylist =
        PlayListModel(playListName: name, playlist: forThisPlayList);
    addPlaylistToDB(thisPlaylist);

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Song added to playlist successfully',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  } else {
    // Show error snackbar if song already exists in the playlist
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'The song is already added to the playlist',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  }
}

void addPlaylistToDB(PlayListModel playListItem) async {
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  int index = 0;
  for (var element in playListDB.values) {
    if (element.playListName == playListItem.playListName) {
      break;
    }
    index++;
  }
  playListDB.putAt(index, playListItem);
  retrieveAllPlaylists();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void removeSongFromPlaylistAndNotify(
    AllSongModel song, String playlisname, int index) async {
  final playlistDB = await Hive.openBox<PlayListModel>('PlayList');
  List<AllSongModel> newlist;

  for (var element in playlistDB.values) {
    if (element.playListName == playlisname) {
      for (var elements in element.playlist!) {
        if (song.id == elements.id) {
          element.playlist!.remove(elements);
          newlist = element.playlist!;
          final newplaylist =
              PlayListModel(playListName: playlisname, playlist: newlist);
          playlistDB.putAt(index, newplaylist);
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          playlistnotifier.notifyListeners();
          break;
        }
      }
    }
  }
}

ValueNotifier<List<AllSongModel>> mostPlayedList =
    ValueNotifier<List<AllSongModel>>([]);

mostplayedadd(AllSongModel song) async {
  final Box<int> mostPlayedDB = await Hive.openBox('MostPLayed');
  int count = (mostPlayedDB.get(song.id) ?? 0) + 1;
  mostPlayedDB.put(song.id, count);
  if (count > 4 && !mostPlayedList.value.contains(song)) {
    mostPlayedList.value.add(song);
  }
  if (mostPlayedList.value.length > 10) {
    mostPlayedList.value = mostPlayedList.value.sublist(0, 10);
  }
}
