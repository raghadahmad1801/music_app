import 'package:flutter/material.dart';
import 'package:music_app1/controller/player_music_controller.dart';
import 'package:music_app1/features/home/screens/home_screen.dart';
import 'package:music_app1/features/onBoarding/screens/on_boarding_page.dart';
import 'package:music_app1/features/playerMusic/screens/player_music_page.dart';
import 'package:music_app1/features/spalch/screens/splach_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  void dispose() {
    @override
    void dispose() {
      PlayerMusicController playMusicController = PlayerMusicController();
      playMusicController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "SplachPage",
      debugShowCheckedModeBanner: false,
      routes: {
        "SplachPage": (context) => SplachPage(),
        "OnBoardingPage": (context) => OnBoardingPage(),
        "HomePage": (context) => HomeScreen(),
        "playerMusicPage": (context) => PlayerMusicPage(),
      },
    );
  }
}
