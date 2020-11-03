// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class AnimatedBottomBanner extends StatefulWidget {
  @override
  _AnimatedBottomBannerState createState() => _AnimatedBottomBannerState();
}

class _AnimatedBottomBannerState extends State<AnimatedBottomBanner>
    with SingleTickerProviderStateMixin<AnimatedBottomBanner> {
  late AnimationController _animationController;
  late Animation<Offset> _position;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _position = TweenSequence([
      TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ),
          weight: 20),
      TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ),
          weight: 60),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ),
        weight: 20,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.ease),
      ),
    );
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

    final ribbon = Container(
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
    );

    return SlideTransition(
      position: _position,
      child: ribbon,
    );
  }
}
