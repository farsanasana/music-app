import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import 'package:newwwone/DB/Db_fuctions.dart';
import 'package:newwwone/Screens/NowplayingScreen.dart';
import 'package:newwwone/Screens/SlashScreen.dart';
import 'package:newwwone/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => MiniPlayerState();
}

int index = 0;

class MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return assetsAudioPlayer.builderCurrent(
      builder: (context, playing) {
        int currentId = int.tryParse(playing.audio.audio.metas.id!) ?? 0;
        for (var element in allSongs) {
          if (element.id == currentId) {
            recentadd(element);
          }
        }

        return buildMiniPlayer(playing);
      },
    );
  }

  Widget buildMiniPlayer(Playing playing) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(35),
          color: KBprimary,
          border: Border.all(color: Kprimary, width: 2),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NowPlayingScreen(),
              ),
            );
          },
          child: Row(
            children: [
              QueryArtworkWidget(
                id: int.tryParse(playing.audio.audio.metas.id!) ?? 0,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const CircleAvatar(
                  backgroundImage: AssetImage('assets/dummy.jpg'),
                ),
                artworkFit: BoxFit.fill,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Marquee(
                  velocity: 25,
                  text: assetsAudioPlayer.getCurrentAudioTitle,
                  blankSpace: 60,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildPlayerControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerControls() {
    return PlayerBuilder.isPlaying(
      player: assetsAudioPlayer,
      builder: (context, isPlaying) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                await assetsAudioPlayer.previous();
                setState(() {});
                if (!isPlaying) {
                  assetsAudioPlayer.pause();
                }
              },
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                await assetsAudioPlayer.playOrPause();
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                await assetsAudioPlayer.next();
                setState(() {});
                if (!isPlaying) {
                  assetsAudioPlayer.pause();
                }
              },
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
