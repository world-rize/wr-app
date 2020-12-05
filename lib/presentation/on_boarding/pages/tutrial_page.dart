import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  VideoPlayerController _controller;
  bool _startedPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/movie/tutorial.mp4');
    _controller.addListener(() {
      if (_startedPlaying && !_controller.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  Future<bool> started() async {
    await _controller.initialize();
    await _controller.play();
    _startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<bool>(
        future: started(),
        builder: (context, ss) {
          if (ss.data) {
            return AspectRatio(aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}