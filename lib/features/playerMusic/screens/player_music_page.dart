import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/controller/player_music_controller.dart';
import 'package:music_app1/core/resources/constants.dart';
import 'package:music_app1/features/playerMusic/widgets/custom_app_bar.dart';
import 'package:music_app1/features/playerMusic/widgets/custom_player_music.dart';
import 'package:music_app1/features/playerMusic/widgets/duration_player_music.dart';

class PlayerMusicPage extends StatefulWidget {
  const PlayerMusicPage({super.key});

  @override
  State<PlayerMusicPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PlayerMusicPage> {
  late PlayerMusicController playerMusicController;
  late int index;

  void initState() {
    super.initState();
    playerMusicController = PlayerMusicController();
  }

  void didChangeDependencies() {
    index = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
    playerMusicController.load(index);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),

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

          Column(
            children: [
              StreamBuilder<int>(
                stream: playerMusicController.indexOutput,
                builder: (context, asyncSnapshot) {
                  return CustomPlayerMusic(
                    songModel: Constants.songList[asyncSnapshot.data ?? index],
                  );
                },
              ),
              Gap(30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      playerMusicController.onTapRandom();
                    },
                    child: Icon(Icons.shuffle, color: Color(0xffFFFFFF)),
                  ),

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff854F9F), Color(0xffB1AFE9)],
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        playerMusicController.backTap();
                      },
                      child: Icon(
                        Icons.skip_previous,
                        color: Color(0xffFFFFFF),
                        size: 20,
                      ),
                    ),
                  ),

                  Container(
                    width: 61,
                    height: 61,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffB1AFE9),
                    ),
                    child: IconButton(
                      onPressed: () {
                        playerMusicController.audioState();
                      },
                      icon: StreamBuilder<bool>(
                        stream: playerMusicController.output,
                        builder: (context, asyncSnapshot) {
                          return asyncSnapshot.data == true
                              ? Icon(
                                  Icons.pause,
                                  color: Color(0xffFFFFFF),
                                  size: 24,
                                )
                              : Icon(
                                  Icons.play_arrow,
                                  color: Color(0xffFFFFFF),
                                  size: 24,
                                );
                        },
                      ),
                    ),
                  ),

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff854F9F), Color(0xffB1AFE9)],
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        playerMusicController.nextTap();
                      },
                      child: Icon(
                        Icons.skip_next,
                        color: Color(0xffFFFFFF),
                        size: 20,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      playerMusicController.loopStatusMode();
                    },
                    child: StreamBuilder(
                      stream: playerMusicController.loopOutput,
                      builder: (context, asyncSnapshot) {
                        return asyncSnapshot.data == true
                            ? Icon(
                                Icons.repeat_one,
                                color: Color(0xffFFFFFF),
                                size: 25,
                              )
                            : Icon(
                                Icons.repeat,
                                color: Color(0xffFFFFFF),
                                size: 25,
                              );
                      },
                    ),
                  ),
                ],
              ),

              Gap(15),

              StreamBuilder<double>(
                stream: playerMusicController.sliderValueOutputData,
                builder: (context, asyncSnapshot) {
                  return Slider(
                    value: asyncSnapshot.data == null
                        ? 0
                        : asyncSnapshot.data!.toDouble(),
                    onChanged: playerMusicController.onChangedThumbSlider,
                    activeColor: Color(0xffB1AFE9),
                    inactiveColor: Color(0xff2F5D9A),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    DurationPlayerMusic(
                      durationOutput: playerMusicController.durationOutput,
                    ),

                    StreamBuilder(
                      stream: playerMusicController.totalDurationOutput,
                      builder: (context, asyncSnapshot) {
                        return Text(
                          asyncSnapshot.data ??
                              playerMusicController.formatDuration(
                                playerMusicController.audioTime,
                              ),
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              color: Color(0xffB1AFE9),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Gap(25),

              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 362,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Up Next",
                                style: GoogleFonts.orbitron(
                                  textStyle: TextStyle(
                                    color: Color(0xffB1AFE9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              Text(
                                "Queue",
                                style: GoogleFonts.orbitron(
                                  textStyle: TextStyle(
                                    color: Color(0xffB1AFE9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: AssetImage(
                                "assets/images/Justin-bieber.png",
                              ),
                              fit: BoxFit.cover,
                              width: 55,
                              height: 55,
                            ),
                          ),
                          title: Text(
                            "sing me to sleep",
                            style: GoogleFonts.orbitron(
                              textStyle: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "alan walker",
                            style: GoogleFonts.orbitron(
                              textStyle: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.skip_next,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
