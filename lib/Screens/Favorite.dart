import 'package:flutter/material.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/Screens/MiniPlayer.dart';
import 'package:newwwone/Screens/NowplayingScreen.dart';
import 'package:newwwone/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPprimary,
        appBar: AppBar(
          backgroundColor: KBprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'My favorites',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: ValueListenableBuilder(
            valueListenable: fav,
            builder: (context, value, child) {
              return Row(
                children: [
                  Expanded(
                    child: fav.value.isEmpty
                        ? const Center(
                            child: Text('No favorite songs available'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
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
                                          id: fav.value[index].id!,
                                          type: ArtworkType.AUDIO),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          audioConverter(fav.value, index);

                                          // Move the navigation to NowPlayingScreen here
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NowPlayingScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 70,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Kprimary),
                                          child: ListTile(
                                            title: Text(
                                              fav.value[index].name!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              maxLines: 1,
                                            ),
                                            subtitle: Text(
                                                fav.value[index].artist ??
                                                    'unknown',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                                maxLines: 1),
                                            trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (fav.value.contains(
                                                      fav.value[index])) {
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
                                                              child: const Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                removeFromFav(fav
                                                                    .value[
                                                                        index]
                                                                    .id!);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                        'Song is removed from favorites successfully'),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
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
                                                        fav.value[index].id!);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Song added to favorites successfully'),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    );
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                () {
                                                  if (fav.value.contains(
                                                      fav.value[index])) {
                                                    return Icons.favorite;
                                                  } else {
                                                    return Icons
                                                        .favorite_border;
                                                  }
                                                }(),
                                                color: () {
                                                  if (fav.value.contains(
                                                      fav.value[index])) {
                                                    return Colors.red;
                                                  } else {
                                                    return Colors.black;
                                                  }
                                                }(),
                                                size: 20,
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
                            itemCount: fav.value.length),
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
