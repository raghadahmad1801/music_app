import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/features/home/screens/home_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
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

        Padding(
          padding: const EdgeInsets.only(left: 70, right: 70, top: 100),
          child: Column(
            //  mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                textAlign: TextAlign.center,

                TextSpan(
                  text: "Find Your\nFavourite\n",

                  style: GoogleFonts.orbitron(
                    color: Color(0xffFFFFFF),
                    textStyle: TextStyle(fontSize: 50),
                    decoration: TextDecoration.none,
                  ),

                  children: [
                    TextSpan(
                      text: "Music\n",

                      style: GoogleFonts.orbitron(
                        color: Color(0xff80CFF2),
                        textStyle: TextStyle(fontSize: 50),
                        // height: 2,
                      ),
                    ),

                    TextSpan(
                      text:
                          "Find Your Latest Favourite Music\nFrom Our Collection",

                      style: GoogleFonts.orbitron(
                        color: Color(0xffFFFFFF),
                        textStyle: TextStyle(fontSize: 14),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          // top: 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Container(
              width: 171,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff3097C5),
                    Color(0xffFFFFFF).withOpacity(0.1),
                  ],
                ),
                border: Border.all(color: Color(0xffFFFFFF), width: 1),
              ),

              child: Center(
                child: Text(
                  "Get Started",

                  style: GoogleFonts.orbitron(
                    color: Color(0xffFFFFFF),
                    textStyle: TextStyle(fontSize: 18),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Image(
            image: AssetImage("assets/images/onBoardingImage.png"),
            width: 410,
            height: 420,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
