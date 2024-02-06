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
