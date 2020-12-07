import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wr_app/presentation/root_view.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:chewie/chewie.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _player;

  /// ホームへ移動
  Future<void> _gotoHome() {
    // initial login
    Provider.of<SystemNotifier>(context, listen: false)
        .setFirstLaunch(value: false);

    // login のみ
    // sendEvent(event: AnalyticsEvent.logIn);

    Navigator.popUntil(context, (route) => route.isFirst);

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootView(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/movies/tutorial.mp4');
    _player = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      fullScreenByDefault: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const closeButton = Positioned(
      right: 10,
      top: 10,
      child: CloseButton(
        color: Colors.white,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Chewie(controller: _player),

          closeButton,
        ],
      ),
    );
  }
}
