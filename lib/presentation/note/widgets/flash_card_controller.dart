// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class FlashCardController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fn = Provider.of<FlashCardNotifier>(context);

    final loopButton = InkWell(
      child: Icon(
        Ionicons.ios_sync,
        color: fn.autoScroll ? Colors.black54 : Colors.grey,
        size: GFSize.MEDIUM,
      ),
      onTap: () async {
        fn.toggleAutoScroll();
        await HapticFeedback.lightImpact();
      },
    );

    final shuffleButton = InkWell(
      onTap: () {
        final fn = context.read<FlashCardNotifier>();
        fn.play();
        print('tapped');
        HapticFeedback.lightImpact();
      },
      child: const Icon(
        Ionicons.ios_shuffle,
        color: Colors.black54,
        size: GFSize.MEDIUM,
      ),
    );

    final accentChoices = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['en-us', 'en-uk', 'en-au', 'en-in']
          .map((locale) => Expanded(
                flex: 1,
                child: FlatButton(
                  onPressed: () {
                    print(locale);
                  },
                  child: Image.asset(
                    'assets/icon/locale_$locale.png',
                  ),
                ),
              ))
          .toList(),
    );

    final playButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await HapticFeedback.lightImpact();
            if (fn.isPlaying) {
              await fn.stop();
            } else if (fn.isStopped) {
              await fn.play();
              print('tapped');
              while (fn.autoScroll) {
                await HapticFeedback.lightImpact();
                await fn.play();
              }
            } else {
              throw Exception('unknown state ${fn.ttsState}');
            }
          },
          child: Icon(
            fn.isPlaying ? Ionicons.ios_square : Icons.play_arrow,
            color: fn.isPlaying ? Colors.black54 : Colors.grey,
            size: 60,
          ),
        ),
      ],
    );

    final buttons = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: loopButton,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: playButton,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: shuffleButton,
        ),
      ],
    );

    return ShadowedContainer(
      color: Colors.white30,
      child: Padding(
        padding: const EdgeInsets.all(8),
        key: GlobalKey(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // player control
              Padding(
                padding: const EdgeInsets.all(8),
                child: buttons,
              ),

              // pitch slider
              const Padding(
                padding: EdgeInsets.all(8),
                child: Placeholder(
                  fallbackHeight: 50,
                ),
              ),

              // accent
              Padding(
                padding: const EdgeInsets.all(8),
                child: accentChoices,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
