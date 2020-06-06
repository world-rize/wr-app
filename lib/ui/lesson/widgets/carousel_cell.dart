// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/ui/widgets/locked_view.dart';

class CarouselCell extends StatelessWidget {
  const CarouselCell({
    @required this.lesson,
    @required this.index,
    @required this.onTap,
    this.locked = false,
  });

  final Lesson lesson;
  final int index;
  final Function onTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: LockedView(
          locked: locked,
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  lesson.assets.img['thumbnail'],
                  fit: BoxFit.cover,
                  height: size.height,
                  width: size.width,
                ),
                ClipRect(
                  child: Container(
                    color: const Color.fromRGBO(128, 128, 128, 0.5),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('No.${index + 1}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      lesson.title['ja'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Text(
                      I.of(context).lessonStatus(0, lesson.phrases.length),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
