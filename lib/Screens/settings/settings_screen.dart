import 'package:flutter/material.dart';
import 'package:newwwone/Screens/settings/privacy_policy_screen.dart';
import 'package:newwwone/Screens/settings/terms_and_conditions_screen.dart';
import 'package:newwwone/colors.dart';
import 'about_us_screen.dart';
import 'package:share_plus/share_plus.dart'; // Import the share_plus package

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KBprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Share The App',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    _shareApp(); // Call the share method when the button is pressed
                  },
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.privacy_tip),
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const TermsAndConditionsScreen(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: KPprimary,
      ),
    );
  }

  // Method to show the share dialog with a predefined text
  void _shareApp() {
    const String text = 'my app link';
    Share.share(text);
  }
}
