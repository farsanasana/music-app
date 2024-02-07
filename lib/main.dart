import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newwwone/DB/main_Models.dart';
import 'package:newwwone/Screens/SlashScreen.dart';

Future<void> main() async {
  // Initialize Hive and register adapters
  await Hive.initFlutter();

  // Register adapters
  if (!Hive.isAdapterRegistered(AllSongModelAdapter().typeId)) {
    Hive.registerAdapter(AllSongModelAdapter());
    if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
      Hive.registerAdapter(FavoriteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
      Hive.registerAdapter(PlayListModelAdapter());
    }
  }
  // Open the 'favorite' box
  await Hive.openBox<AllSongModel>('favorite');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SlashScreen(),
    );
  }
}
