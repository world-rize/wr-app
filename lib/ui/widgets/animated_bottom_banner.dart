// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class AnimatedBottomBanner extends StatefulWidget {
  @override
  _AnimatedBottomBannerState createState() => _AnimatedBottomBannerState();
}

class _AnimatedBottomBannerState extends State<AnimatedBottomBanner>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  SequenceAnimation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ),
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
          tag: 'offset',
        )
        .addAnimatable(
          animatable: Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ),
          from: const Duration(milliseconds: 1000),
          to: const Duration(milliseconds: 2000),
          curve: Curves.easeIn,
          tag: 'offset',
        )
        .addAnimatable(
          animatable: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(1, 0),
          ),
          from: const Duration(milliseconds: 2000),
          to: const Duration(milliseconds: 3000),
          curve: Curves.easeIn,
          tag: 'offset',
        )
        .animate(_animationController);
  }

  void animate() {
    print('animate');
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController.isCompleted) {
      return SizedBox.shrink();
    }

    return SlideTransition(
      position: _animation['offset'].value,
      child: Container(
        color: Colors.green,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'XXX',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
