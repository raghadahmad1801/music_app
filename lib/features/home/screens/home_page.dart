import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/controller/home_controller.dart';
import 'package:music_app1/core/resources/constants.dart';
import 'package:music_app1/features/home/widgets/custom_song_to_play.dart';
import 'package:music_app1/features/home/widgets/recomeded_song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  late HomeController homeController;
  void initState() {
    homeController = HomeController();
  }

  void dispose() {
    homeController.dispose();
    super.dispose();
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

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 55),
                  child: StreamBuilder(
                    stream: homeController.outStatusOutput,
                    builder: (context, asyncSnapshot) {
                      return TextField(
                        onTap: () {
                          homeController.onTapStatus();
                        },

                        onSubmitted: (value) {
                          homeController.searchList(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Search Song",
                          hintStyle: TextStyle(color: Color(0xffFFFFFF)),
                          suffixIcon: asyncSnapshot.data == true
                              ? InkWell(
                                  onTap: () {
                                    homeController.onTapOutSide();
                                  },
                                  child: Icon(Icons.clear),
                                )
                              : null,
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xffFFFFFF)),
                          ),
                          filled: true,
                          fillColor: Color(0xffB1AFE9),
                        ),
                      );
                    },
                  ),
                ),

                Gap(20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Recently Played",
                        style: GoogleFonts.orbitron(
                          textStyle: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    Gap(20),

                    StreamBuilder(
                      stream: homeController.listOutput,
                      builder: (context, asyncSnapshot) {
                        // لو لسه ما صار بحث أو الصفحة أول ما تفتح
                        if (!asyncSnapshot.hasData) {
                          return SizedBox(); // ما يعرض شي
                        }

                        // لو صار بحث والداتا فاضية
                        if (asyncSnapshot.data != null &&
                            asyncSnapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No Found",
                              style: GoogleFonts.orbitron(
                                textStyle: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }

                        // لو في نتائج بحث
                        return CustomSongToPlay(
                          onTap: (index) {
                            HomeController.navigatorToPlayerMusic(
                              context: context,
                              index: index,
                            );
                          },
                          songModelList: asyncSnapshot.data!,
                          itemCount: asyncSnapshot.data!.length,
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Recommanded music",
                        style: GoogleFonts.orbitron(
                          textStyle: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 800,

                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            RecomededSong(songModel: Constants.songList[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemCount: Constants.songList.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
