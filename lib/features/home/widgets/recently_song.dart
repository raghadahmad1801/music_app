import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/model/song_model.dart';

class RecentlySong extends StatelessWidget {
  const RecentlySong({super.key, required this.songModel});

  final SongModel songModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image(
            image: AssetImage(songModel.image),
            width: 151,
            height: 151,
            fit: BoxFit.cover,
          ),
        ),
        Gap(5),
        Text(
          songModel.song,
          style: GoogleFonts.orbitron(
            textStyle: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Text(
          songModel.singer,
          style: GoogleFonts.orbitron(
            textStyle: TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
          ),
        ),
      ],
    );
  }
}
