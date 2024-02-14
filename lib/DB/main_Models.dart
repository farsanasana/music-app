// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'main_Models.g.dart';

@HiveType(typeId: 1)
class AllSongModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? uri;

  AllSongModel(
      {required this.name,
      required this.artist,
      required this.duration,
      required this.id,
      required this.uri});
}

@HiveType(typeId: 2)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int? id;

  FavoriteModel({required this.id});
}

@HiveType(typeId: 3)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String? playListName;
  @HiveField(1)
  List<AllSongModel>? playlist = [];
  PlayListModel({required this.playListName, this.playlist});
}
