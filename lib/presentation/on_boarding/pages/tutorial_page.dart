import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/on_boarding/notifier/tutorial_page_notifier.dart';
import 'package:wr_app/usecase/system_service.dart';

// TutorialPage with Notifier
class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<TutorialPageNotifier>.value(
      value: TutorialPageNotifier(
        systemService: GetIt.I<SystemService>(),
      ),
      child: _TutorialPage(),
    );
  }
}

class _TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TutorialPageNotifier>(context);

    final closeButton = Positioned(
      right: 10,
      top: 10,
      child: CloseButton(
        color: Colors.white,
        onPressed: () => state.gotoHome(context),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Chewie(controller: state.player),

          closeButton,
        ],
      ),
    );
  }
}
