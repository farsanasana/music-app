import 'package:flutter/material.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/MiniPlayer.dart';
import 'package:newwwone/Screens/NowplayingScreen.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:newwwone/colors.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SinglePlayListScreen extends StatelessWidget {
  String playlistname;
  final int idx;
  final PlayListModel listIndex;
  SinglePlayListScreen({
    super.key,
    required this.playlistname,
    required this.listIndex,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPprimary,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.white,
            ),
          ),
          backgroundColor: KBprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Text(
            playlistname,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showPlaylistSheet(context, playlistname);
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
              iconSize: 28,
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: ValueListenableBuilder(
            valueListenable: playlistnotifier,
            builder: (context, value, child) {
              return Row(
                children: [
                  Expanded(
                    child: playlistnotifier.value[idx].playlist?.isEmpty ?? true
                        ? const Center(
                            child: Text(
                              'please add some songs',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final data =
                                  playlistnotifier.value[idx].playlist![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: QueryArtworkWidget(
                                        artworkClipBehavior: Clip.none,
                                        artworkHeight: 70,
                                        artworkWidth: 70,
                                        nullArtworkWidget: Image.asset(
                                          'assets/dummy.jpg',
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                        ),
                                        id: playlistnotifier
                                            .value[idx].playlist![index].id!,
                                        type: ArtworkType.AUDIO,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          audioConverter(
                                              listIndex.playlist!, index);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NowPlayingScreen(
                                                music:
                                                    listIndex.playlist![index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 70,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: KBprimary,
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              playlistnotifier.value[idx]
                                                      .playlist![index].name ??
                                                  "song name",
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              playlistnotifier
                                                      .value[idx]
                                                      .playlist![index]
                                                      .artist ??
                                                  'unknown',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            trailing: PopupMenuButton(
                                                icon: const Icon(
                                                    Icons.more_vert,
                                                    size: 20,
                                                    color: Colors.white),
                                                itemBuilder:
                                                    (BuildContext context) {
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
                                                      value: 'delete',
                                                      child: Text(
                                                          'Delete from playlist'),
                                                    ),
                                                  ];
                                                },
                                                onSelected: (String value) {
                                                  if (value == 'favorites') {
                                                    if (fav.value.contains(
                                                        allSongs[index])) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
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
                                                                child:
                                                                    const Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  removeFromFav(
                                                                      allSongs[
                                                                              index]
                                                                          .id!);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          const Text(
                                                                        'Song is removed from favorites successfully',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    const Text(
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
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: const Text(
                                                            'Song added to favorites successfully',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          backgroundColor:
                                                              Colors.green,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else if (value ==
                                                      'delete') {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Confirmation'),
                                                          content: const Text(
                                                              'Are you sure you want to remove the song from the playlist?'),
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
                                                                removeSongFromPlaylistAndNotify(
                                                                    data,
                                                                    playlistname,
                                                                    idx);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                                                  }
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount:
                                playlistnotifier.value[idx].playlist!.length,
                          ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}

showPlaylistSheet(BuildContext context, String playlistname) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = allSongs[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: QueryArtworkWidget(
                          artworkClipBehavior: Clip.none,
                          artworkHeight: 70,
                          artworkWidth: 70,
                          nullArtworkWidget: Image.asset(
                            'assets/dummy.jpg',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          id: allSongs[index].id!,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            addSongToPlaylistAndShowSnackbar(
                                data, playlistname, context);
                          },
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: KBprimary,
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 1,
                                ),
                              ),
                              subtitle: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].artist ?? 'unknown',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: allSongs.length,
            ),
          ),
        ),
      );
    },
  );
}
