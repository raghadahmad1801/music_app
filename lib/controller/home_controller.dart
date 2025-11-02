import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_app1/core/resources/constants.dart';
import 'package:music_app1/model/song_model.dart';

class HomeController {
  bool tapStatus = false;
  late StreamController<bool> streamController;
  late Sink<bool> input;
  late Stream<bool> output;

  late StreamController<List<SongModel>> listStreamController;
  late Sink<List<SongModel>> listInput;
  late Stream<List<SongModel>> listOutput;

  late StreamController<bool> outStatusStreamController;
  late Sink<bool> outStatusinput;
  late Stream<bool> outStatusOutput;
  List<SongModel> songList = [];
  HomeController() {
    streamController = StreamController();
    input = streamController.sink;
    output = streamController.stream.asBroadcastStream();
    outStatusStreamController = StreamController();
    outStatusinput = outStatusStreamController.sink;
    outStatusOutput = outStatusStreamController.stream;

    listStreamController = StreamController();
    listInput = listStreamController.sink;
    listOutput = listStreamController.stream.asBroadcastStream();
  }

  void onTapStatus() {
    tapStatus = true;
    input.add(tapStatus);
    outStatusinput.add(tapStatus);
  }

  void onTapOutSide() {
    tapStatus = false;
    outStatusinput.add(tapStatus);
    input.add(tapStatus);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void searchList(String value) {
    List<SongModel> song = Constants.songList
        .where(
          (element) => element.song.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();

    songList.clear();
    songList = song;

    listInput.add(songList);
  }

  static List homeIcon = [
    Icon(Icons.align_horizontal_left),
    Icon(Icons.favorite_outline),
    Icon(Icons.list),
    Icon(Icons.settings),
  ];

  static void navigatorToPlayerMusic({
    required BuildContext context,
    required int index,
  }) {
    Navigator.pushNamed(context, "playerMusicPage", arguments: index);
  }

  void dispose() {
    streamController.close();
    input.close();

    listStreamController.close();
    listInput.close();

    outStatusStreamController.close();
    outStatusinput.close();
  }
}
