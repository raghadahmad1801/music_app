import 'dart:async';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app1/core/resources/constants.dart';

class PlayerMusicController {
  late int index = 0;
  late AudioCache audioCache;
  late Uri uri;
  late AudioPlayer audioPlayer;
  late StreamController<bool> streamController;
  late Sink<bool> input;
  late Stream<bool> output;
  bool isPlaying = false;

  late StreamController<int> indexstreamController;
  late Sink<int> indexInput;
  late Stream<int> indexOutput;

  late StreamController<bool> loopStreamController;
  late Sink<bool> loopInput;
  late Stream<bool> loopOutput;
  bool loopStatus = false;

  double valueSlider = 0;

  late StreamController<Duration> durationStreamController;
  late Sink<Duration> durationInput;
  late Stream<String> durationOutput;

  late StreamController<Duration> totalDurationStreamController;
  late Sink<Duration> totalDurationInput;
  late Stream<String> totalDurationOutput;
  late StreamController<Duration> sliderValueStreamController;
  late Sink<Duration> sliderValueInputData;
  late Stream<double> sliderValueOutputData;

  PlayerMusicController._internal() {
    audioCache = AudioCache(prefix: "assets/");

    audioPlayer = AudioPlayer();
    streamController = StreamController();
    input = streamController.sink;
    output = streamController.stream.asBroadcastStream();
    indexstreamController = StreamController();
    indexInput = indexstreamController.sink;
    indexOutput = indexstreamController.stream.asBroadcastStream();
    loopStreamController = StreamController();
    loopInput = loopStreamController.sink;
    loopOutput = loopStreamController.stream.asBroadcastStream();
    durationStreamController = StreamController();
    durationInput = durationStreamController.sink;
    durationOutput = durationStreamController.stream.asBroadcastStream().map(
      (event) => formatDuration(event),
    );

    totalDurationStreamController = StreamController();
    totalDurationInput = totalDurationStreamController.sink;
    totalDurationOutput = totalDurationStreamController.stream
        .asBroadcastStream()
        .map((event) => formatDuration(event));

    sliderValueStreamController = StreamController();
    sliderValueInputData = sliderValueStreamController.sink;
    sliderValueOutputData = sliderValueStreamController.stream
        .asBroadcastStream()
        .map((event) => transferDurationToValueSlider(event));
  }

  static PlayerMusicController _instance = PlayerMusicController._internal();

  factory PlayerMusicController() {
    return _instance;
  }

  double transferDurationToValueSlider(Duration duration) {
    if (audioTime.inSeconds == 0) return 0.0;
    double durationNowInSecond = duration.inSeconds.toDouble();
    double maxTime = audioTime.inSeconds.toDouble();
    valueSlider = (durationNowInSecond / maxTime);
    return valueSlider.clamp(0.0, 1.0);
  }

  void onChangedThumbSlider(double value) {
    Duration duration = transferValueSliderToDuration(value);
    audioPlayer.seek(duration);
  }

  Duration transferValueSliderToDuration(double sliderValue) {
    double valueNow = (sliderValue / 1.0) * audioTime!.inSeconds.toDouble();

    return Duration(seconds: valueNow.toInt());
  }

  Duration audioTime = Duration.zero;
  Future<void> load(int index) async {
    uri = await audioCache.load(Constants.songList[index].songPath);

    // أوقف أي تشغيل قديم
    await audioPlayer.stop();

    // ضبط القيمة الابتدائية للوقت الحالي للصفر
    durationInput.add(Duration.zero);
    sliderValueInputData.add(Duration.zero);

    // شغّل الأغنية الجديدة
    await audioPlayer.play(UrlSource(uri.toString()));

    // نراقب المدة الإجمالية
    audioPlayer.onDurationChanged.listen((duration) {
      audioTime = duration;
      totalDurationInput.add(duration);
    });

    // نراقب الموقع الحالي (زمن التشغيل)
    audioPlayer.onPositionChanged.listen((position) {
      durationInput.add(position);
      sliderValueInputData.add(position);
    });

    // لما يخلص المقطع
    audioPlayer.onPlayerComplete.listen((event) {
      nextTap();
    });

    isPlaying = true;
    input.add(isPlaying);
    indexInput.add(index);

    await Future.delayed(const Duration(milliseconds: 200));

    // لو بعد التأخير المدة لسه صفر، نجرب نسحبها يدويًا
    if (audioTime.inSeconds == 0) {
      final duration = await audioPlayer.getDuration();
      if (duration != null && duration.inSeconds > 0) {
        audioTime = duration;
        totalDurationInput.add(duration);
      }
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void audioState() {
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
      isPlaying = false;
      input.add(isPlaying);
    } else if (audioPlayer.state == PlayerState.paused) {
      audioPlayer.resume();
      isPlaying = true;
      input.add(isPlaying);
    }
  }

  void nextTap() {
    if (index < Constants.songList.length - 1) {
      index++;
    } else {
      index = 0;
    }
    load(index);
  }

  void backTap() {
    if (index == 0) {
      index = Constants.songList.length - 1;
    } else {
      index--;
    }
    load(index);
  }

  void onTapRandom() {
    int i = math.Random().nextInt(Constants.songList.length);
    if (i == index) i = math.Random().nextInt(Constants.songList.length);
    index = i;
    load(index);
  }

  void loopStatusMode() {
    if (audioPlayer.releaseMode == ReleaseMode.loop) {
      audioPlayer.setReleaseMode(ReleaseMode.release);
      loopStatus = false;
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      loopStatus = true;
    }
    loopInput.add(loopStatus);
  }

  void dispose() {
    audioPlayer.dispose();
    streamController.close();
    input.close();
    indexstreamController.close();
    indexInput.close();
    loopStreamController.close();
    loopInput.close();
    durationStreamController.close();
    durationInput.close();
    totalDurationStreamController.close();
    totalDurationInput.close();
    sliderValueStreamController.close();
    sliderValueInputData.close();
  }
}
