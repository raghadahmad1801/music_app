import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app1/model/song_model.dart';

class RecomededSong extends StatefulWidget {
  const RecomededSong({super.key, required this.songModel});
  final SongModel songModel;

  @override
  State<RecomededSong> createState() => _RecomededSongState();
}

class _RecomededSongState extends State<RecomededSong> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 36,
        backgroundImage: AssetImage(widget.songModel.image),
      ),
      title: Text(
        widget.songModel.song,
        style: GoogleFonts.orbitron(
          textStyle: const TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: Text(
        widget.songModel.singer,
        style: GoogleFonts.orbitron(
          textStyle: const TextStyle(
            color: Color(0xffB1AFE9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            isFavourite = !isFavourite;
          });
        },
        child: Icon(
          Icons.favorite_outline,
          color: isFavourite ? Colors.red : const Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
