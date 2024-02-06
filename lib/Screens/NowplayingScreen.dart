import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/MiniPlayer.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:newwwone/Screens/playlist/Add_to_playlist.dart';
import 'package:newwwone/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:marquee/marquee.dart';

// ignore: must_be_immutable
class NowPlayingScreen extends StatefulWidget {
  final AllSongModel? music;
  const NowPlayingScreen({
    Key? key,
    this.songs,
    this.music,
  }) : super(key: key);
  final List<SongModel>? songs;
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  // String selectedChoice = 'Music';
  bool isRepeat = false;
  bool isShuffle = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPprimary,
        appBar: AppBar(
          backgroundColor: KBprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(55),
            ),
          ),
          title: const Text(
            'Now Playing',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddToPlaylistsScreen(
                      music: allSongs[index],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.playlist_add),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: assetsAudioPlayer.builderCurrent(
            builder: (context, playing) {
              int id = int.parse(playing.audio.audio.metas.id ?? "");
              bool ischecking = favoriteChecking(id);
              findCurrentSong(id);
              mostplayedadd(currentPlayingsong!);
              recentadd(currentPlayingsong!);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.seekBy(
                                const Duration(seconds: -10),
                              );
                            },
                            icon: const Icon(
                              Icons.replay_10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            setState(
                              () {
                                if (ischecking == true) {
                                  removeFromFav(
                                      int.parse(playing.audio.audio.metas.id!));
                                } else {
                                  addToFavorites(
                                      int.parse(playing.audio.audio.metas.id!));
                                }
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 250,
                            height: 250,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: QueryArtworkWidget(
                                  nullArtworkWidget: Image.asset(
                                    'assets/dummy.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  id: int.parse(
                                      playing.audio.audio.metas.id ?? ""),
                                  type: ArtworkType.AUDIO),
                            ),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.seekBy(
                                const Duration(seconds: 10),
                              );
                            },
                            icon: const Icon(
                              Icons.forward_10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              assetsAudioPlayer
                                                  .setPlaySpeed(0.5);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            child: const Text(
                                              '0.5',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              assetsAudioPlayer.setPlaySpeed(1);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            child: const Text(
                                              'Normal',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              assetsAudioPlayer
                                                  .setPlaySpeed(1.5);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            child: const Text(
                                              '1.5',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.speed,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              bool checking = favoriteChecking(
                                int.parse(playing.audio.audio.metas.id!),
                              );
                              setState(() {
                                if (checking == true) {
                                  removeFromFav(
                                    int.parse(playing.audio.audio.metas.id!),
                                  );
                                } else {
                                  addToFavorites(
                                    int.parse(playing.audio.audio.metas.id!),
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              () {
                                if (ischecking == true) {
                                  return Icons.favorite;
                                } else {
                                  return Icons.favorite_border;
                                }
                              }(),
                              color: () {
                                if (ischecking == true) {
                                  return Colors.red;
                                } else {
                                  return Colors.white;
                                }
                              }(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 250,
                          child: Marquee(
                            text: assetsAudioPlayer.getCurrentAudioTitle,
                            velocity: 25,
                            blankSpace: 60,
                            scrollAxis: Axis.horizontal,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          assetsAudioPlayer.getCurrentAudioArtist,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        PlayerBuilder.realtimePlayingInfos(
                          player: assetsAudioPlayer,
                          builder: (context, realtimePlayingInfos) {
                            final duration =
                                realtimePlayingInfos.current!.audio.duration;
                            final position =
                                realtimePlayingInfos.currentPosition;
                            return ProgressBar(
                              thumbGlowColor: Colors.grey,
                              thumbGlowRadius: 8,
                              thumbColor: Colors.blue,
                              thumbRadius: 6,
                              barCapShape: BarCapShape.square,
                              progress: position,
                              total: duration,
                              timeLabelPadding: 15,
                              onSeek: (duration) =>
                                  assetsAudioPlayer.seek(duration),
                              progressBarColor:
                                  const Color.fromARGB(255, 118, 117, 117),
                              baseBarColor:
                                  const Color.fromARGB(255, 205, 199, 199),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                isShuffle = !isShuffle;
                                if (isShuffle) {
                                  assetsAudioPlayer.toggleShuffle();
                                } else {
                                  assetsAudioPlayer
                                      .setLoopMode(LoopMode.playlist);
                                }
                              },
                            );
                          },
                          icon: Icon(
                            isShuffle
                                ? Icons.shuffle_on_rounded
                                : Icons.shuffle_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            assetsAudioPlayer.previous();
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            assetsAudioPlayer.playOrPause();
                          },
                          child: PlayerBuilder.isPlaying(
                            player: assetsAudioPlayer,
                            builder: (context, isPlaying) {
                              return Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: isPlaying
                                    ? Colors.blue
                                    : Colors
                                        .white, // Adjust the colors as needed
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            assetsAudioPlayer.next();
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                isRepeat = !isRepeat;
                                if (isRepeat) {
                                  assetsAudioPlayer
                                      .setLoopMode(LoopMode.single);
                                } else {
                                  assetsAudioPlayer
                                      .setLoopMode(LoopMode.playlist);
                                }
                              },
                            );
                          },
                          icon: Icon(
                            isRepeat ? Icons.repeat_one : Icons.repeat,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
