import 'package:flutter/material.dart';
import 'package:newwwone/colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KBBprimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: MixPrimary)),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Riz Music - Your Ultimate Offline Music Experience',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'At Riz Music, we are dedicated to providing music enthusiasts with a unique and immersive offline music player experience. Our app, built using Flutter, combines cutting-edge technology with a passion for music to deliver a seamless and personalized music journey. With Riz music, you can explore and enjoy your favorite songs, discover new tracks, and enhance your music experience in ways you never thought possible.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our mission is to revolutionize the way you interact with music. We understand that music is more than just a background soundtrack; it\'s an integral part of our lives. Riz music empowers you to dive deep into the world of music, discover new artists, and effortlessly connect with the songs that resonate with your soul. With our advanced features and intuitive interface, we strive to make MeloVibe your go-to destination for offline music playback.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Key Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Adjustable Playback Speed: Customize your listening experience with the adjustable playback speed feature. Whether you want to slow down a fast-paced track or speed up a slow ballad, Riz music lets you control the tempo to match your preferences.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '2. Lyrics Integration: Connect deeply with the music and sing along to your favorite songs with our integrated lyrics feature. Riz Music fetches lyrics in real-time, displaying them on your screen as the song plays. Say goodbye to the frustration of misheard lyrics and enjoy an immersive karaoke-like experience.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '3. Offline Playback: Embrace the freedom of offline music with Riz Music . Download your favorite songs, albums, or playlists to your device and enjoy them anytime, anywhere, even without an internet connection. Whether you\'re on a long flight, commuting underground, or in an area with limited network coverage, your music is always accessible.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '4. Cross-Platform Sync: Seamlessly synchronize your music library and preferences across multiple devices. Whether you\'re using Riz music on your smartphone, tablet, or computer, your music collection and personalized settings stay in perfect harmony, giving you a consistent and seamless experience.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '5. Personalized Recommendations: Discover new music tailored to your taste with our personalized recommendations. Riz music analyzes your listening habits, genre preferences, and song history to suggest artists, albums, and tracks that align with your musical interests, helping you expand your music horizons.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '6. Customization Options: Make Riz music reflect your unique style and preferences. Customize the app\'s appearance, themes, and player interface to suit your mood and enhance your overall music experience.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'We are committed to continuously improving Riz music and providing you with the best offline music player on the market. Our team of dedicated developers and music enthusiasts work tirelessly to enhance our features, integrate new technologies, and bring you regular updates that elevate your music journey.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Join the Riz music community today and immerse yourself in a world of music like never before. Let the rhythms, melodies, and lyrics resonate deep within your soul as you explore the vast universe of offline music with MeloVibe.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Happy Vibing!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'The Riz music Team',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: KPprimary,
    );
  }
}
