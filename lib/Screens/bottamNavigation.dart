import 'package:flutter/material.dart';
import 'package:newwwone/Screens/Allsongs.dart';
import 'package:newwwone/Screens/Favorite.dart';
import 'package:newwwone/Screens/MiniPlayer.dart';
import 'package:newwwone/Screens/MostlyPlayed.dart';
import 'package:newwwone/Screens/playlist/PlaylistScreen.dart';
import 'package:newwwone/Screens/Recent.dart';
import 'package:newwwone/colors.dart';

final ValueNotifier<int> _currentIndex = ValueNotifier(0);

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final screen = [
    const Allsongs(),
    const RecentlyPlayedScreen(),
    const PlaylistScreen(),
    const MostlyPlayedScreen(),
    const MyFavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, updatedIndex, child) {
            return screen[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: KBprimary),
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (BuildContext context, int updatedindex, child) {
            return BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              currentIndex: updatedindex,
              // Set the background color to purple
              onTap: (index) {
                _currentIndex.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.library_music,
                    size: 28,
                  ),
                  label: 'Recent',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_add,
                    size: 28,
                  ),
                  label: 'PlayList',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    size: 28,
                  ),
                  label: 'Mosly Played ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 28,
                  ),
                  label: 'Favorite',
                ),
              ],
            );
          },
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
