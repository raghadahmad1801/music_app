import 'package:flutter/material.dart';
import 'package:music_app1/features/home/screens/home_page.dart';
import 'package:music_app1/features/home/widgets/custom_bottom_nav.dart';
import 'package:music_app1/features/playerMusic/screens/player_music_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

List<Widget> widgets = [
  HomePage(),
  Scaffold(body: Center(child: Text("page2"))),

  PlayerMusicPage(),
  Scaffold(body: Center(child: Text("page4"))),
];

class _MyWidgetState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(index),
      extendBody: true,
      bottomNavigationBar: CustomBottomNav(
        index: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
