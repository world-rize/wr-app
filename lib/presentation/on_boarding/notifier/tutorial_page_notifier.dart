import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wr_app/usecase/system_service.dart';

import '../../root_view.dart';

class TutorialPageNotifier extends ChangeNotifier {
  // TODO: service locator
  factory TutorialPageNotifier({@required SystemService systemService}) {
    return _cache ??= TutorialPageNotifier._(systemService: systemService);
  }

  TutorialPageNotifier._({@required SystemService systemService})
      : _systemService = systemService {
    _videoPlayerController =
        VideoPlayerController.asset('assets/movies/tutorial.mp4');
    player = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      fullScreenByDefault: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    player.dispose();
    super.dispose();
  }

  /// singleton
  static TutorialPageNotifier _cache;

  final SystemService _systemService;

  VideoPlayerController _videoPlayerController;
  ChewieController player;

  // ホームへ移動
  // TODO: name based routing for omit BuildContext
  Future gotoHome(BuildContext context) async {
    await player.pause();

    // initial login
    _systemService.setFirstLaunch(value: false);

    Navigator.popUntil(context, (route) => route.isFirst);

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
  }
}
