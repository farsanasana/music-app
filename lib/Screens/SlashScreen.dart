// ignore_for_file: avoid_web_libraries_in_flutter, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/DB/mainFun.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/bottamNavigation.dart';

import 'package:newwwone/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<AllSongModel> allSongs = [];

class SlashScreen extends StatefulWidget {
  const SlashScreen({Key? key}) : super(key: key);

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gotoHome(context);
    return Scaffold(
      backgroundColor: KBprimary,
      body: Center(child: Image.asset('assets/Logoo.png')),
    );
  }
}

Future<void> initializeApp() async {
  bool hasStoragePermission = false;
  await Future.delayed(const Duration(seconds: 1));
  hasStoragePermission = await CheckPermission.checkAndRequestPermissions();
  if (hasStoragePermission) {
    //---------------------------SongFetch-------------------------
    List<SongModel> fetchSong = await audioQuery.querySongs();
    for (SongModel element in fetchSong) {
      allSongs.add(AllSongModel(
          name: element.displayNameWOExt,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          uri: element.uri));
    }
  }
}

Future<void> gotoHome(BuildContext context) async {
  // Receive the context here
  await Future.delayed(const Duration(seconds: 3));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (ctx) => BottomNavigationScreen()),
  );
  await fetchForRecentlyPlayed();
  await favfetch();
  await fetchForMostlyPlayed();
}

fetchForRecentlyPlayed() async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<AllSongModel> recenttemp = [];
  for (int element in recentDb.values) {
    for (AllSongModel song in allSongs) {
      if (element == song.id) {
        recenttemp.add(song);
        break;
      }
    }
  }
  recentList.value = recenttemp.reversed.toList();
}

fetchForMostlyPlayed() async {
  final Box<int> mostPlayedDB = await Hive.openBox('MostPlayed');
  if (mostPlayedDB.isEmpty) {
    for (AllSongModel elements in allSongs) {
      mostPlayedDB.put(elements.id, 0);
    }
  } else {
    for (int id in mostPlayedDB.keys) {
      int count = mostPlayedDB.get(id) ?? 0;
      if (count > 4) {
        for (AllSongModel element in allSongs) {
          if (element.id == id) {
            mostPlayedList.value.add(element);
            break;
          }
        }
      }
    }
    if (mostPlayedList.value.length > 10) {
      mostPlayedList.value = mostPlayedList.value.sublist(0, 10);
    }
  }
}
