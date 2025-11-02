import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/model/song_model.dart';

class CustomPlayerMusic extends StatelessWidget {
  const CustomPlayerMusic({super.key, required this.songModel});
  final SongModel songModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 90, top: 140, right: 90),
      child: Column(
        children: [
          Container(
            width: 260,
            height: 261,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image(
                image: AssetImage(songModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Gap(25),

          Text(
            "${songModel.song}",
            style: GoogleFonts.orbitron(
              textStyle: TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            "${songModel.singer}",
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
    );
  }
}
