import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/NowplayingScreen.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:newwwone/DB/mainFun.dart';
import 'package:newwwone/Screens/playlist/Add_to_playlist.dart';
import 'package:newwwone/Screens/searchScreen.dart';
import 'package:newwwone/Screens/settings/settings_screen.dart';
import 'package:newwwone/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<AllSongModel>> allSongsNotifier = ValueNotifier([]);

final OnAudioQuery _audioQuery = OnAudioQuery();

class Allsongs extends StatefulWidget {
  const Allsongs({Key? key}) : super(key: key);

  @override
  State<Allsongs> createState() => _AllsongsState();
}

List<AllSongModel> searchlist = allSongsNotifier.value;
TextEditingController search = TextEditingController();

class _AllsongsState extends State<Allsongs> {
  @override
  void initState() {
    fetchSongs();
    super.initState();
  }

  Future<void> fetchSongs() async {
    List<SongModel> fetchSong = await audioQuery.querySongs();
    List<AllSongModel> songs = [];
    for (SongModel element in fetchSong) {
      songs.add(
        AllSongModel(
          name: element.displayNameWOExt,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          uri: element.uri,
        ),
      );
    }

    // Set the new song list to the notifier
    allSongsNotifier.value = songs;
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AllSongModel>('favorite');
    // ignore: unused_local_variable
    List<AllSongModel> songs = box.values.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Kprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: MixPrimary, // Assuming MixPrimary is a List<Color>
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          title: const Text(
            'Riz Music',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              color: Colors.white,
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder<List<SongModel>>(
                    future:
                        _audioQuery.querySongs(), // Use _audioQuery directly
                    builder: (BuildContext context,
                        AsyncSnapshot<List<SongModel>> allsongs) {
                      if (allsongs.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (allsongs.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${allsongs.error}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (allsongs.data == null ||
                          allsongs.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Songs Found",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: QueryArtworkWidget(
                                    artworkClipBehavior: Clip.none,
                                    artworkHeight: 50,
                                    artworkWidth: 50,
                                    nullArtworkWidget: Image.asset(
                                      'assets/music.jpg',
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                    id: allSongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      audioConverter(allSongs,
                                          index); // Uncomment this line if needed
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NowPlayingScreen(
                                                    music: allSongs[index],
                                                  )));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: KBprimary,
                                      ),
                                      child: ListTile(
                                        title: SizedBox(
                                          height: 20,
                                          child: Text(
                                            allsongs.data![index].title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        subtitle: SizedBox(
                                          height: 20,
                                          child: Text(
                                            allsongs.data![index].artist ??
                                                'unknown',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            maxLines: 1,
                                          ),
                                        ),
                                        trailing: PopupMenuButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                value: 'favorites',
                                                child: fav.value.contains(
                                                        allSongs[index])
                                                    ? const Text(
                                                        'Remove from favorites')
                                                    : const Text(
                                                        'Add to favorites'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'playlist',
                                                child: Text('Add to playlist'),
                                              ),
                                            ];
                                          },
                                          onSelected: (String value) {
                                            if (value == 'favorites') {
                                              if (fav.value
                                                  .contains(allSongs[index])) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirmation'),
                                                      content: const Text(
                                                          'Are you sure you want to remove the song from favorites?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            removeFromFav(
                                                                allSongs[index]
                                                                    .id!);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content:
                                                                    const Text(
                                                                  'Song is removed from favorites successfully',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                addToFavorites(
                                                    allSongs[index].id!);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                      'Song added to favorites successfully',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else if (value == 'playlist') {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddToPlaylistsScreen(
                                                    music: allSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemCount: allsongs.data!.length,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
