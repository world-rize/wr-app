// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class FlashCardController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO
    final flashCardNotifier = Provider.of<FlashCardNotifier>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ShadowedContainer(
        color: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.all(8),
          key: GlobalKey(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    final fn = context.read<FlashCardNotifier>();
                    fn.play();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Placeholder(
                    fallbackHeight: 50,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Placeholder(
                    fallbackHeight: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
