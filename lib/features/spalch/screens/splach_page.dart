import 'package:flutter/material.dart';
import 'package:music_app1/features/onBoarding/screens/on_boarding_page.dart';

class SplachPage extends StatefulWidget {
  const SplachPage({super.key});

  @override
  State<SplachPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplachPage> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.20, 0.98),
                end: const Alignment(0.20, 0.98),
                colors: [Color(0xff411F5C), Color(0xff2C17CA).withOpacity(.54)],
              ),
            ),
          ),

          Center(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
