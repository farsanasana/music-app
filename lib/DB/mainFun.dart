import 'package:hive_flutter/hive_flutter.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<bool> checkAndRequestPermissions({bool retry = false}) async {
    bool hasPermission = false;
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    return hasPermission;
  }
}

final OnAudioQuery audioQuery = OnAudioQuery();

class SongFetch {
  permissionRequest() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

favFetch() async {
  List<FavoriteModel> favsongcheck = [];
  Box<FavoriteModel> favdb = await Hive.openBox('fav_DB');
  favsongcheck.addAll(favdb.values);
  for (var favs in favsongcheck) {
    int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        fav.value.insert(0, songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allSongs.length) {
      var key = favs.key;
      favdb.delete(key);
    }
  }
}
