import 'package:flutter/material.dart';
import 'package:music_app1/features/home/widgets/recently_song.dart';
import 'package:music_app1/model/song_model.dart';

class CustomSongToPlay extends StatelessWidget {
  CustomSongToPlay({
    super.key,
    required this.onTap,
    required this.songModelList,
    required this.itemCount,
  });

  final Function(int index) onTap;
  List<SongModel> songModelList;
  int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onTap(index),

          child: RecentlySong(songModel: songModelList[index]),
        ),
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemCount: itemCount,
      ),
    );
  }
}
