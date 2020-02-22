// All the components that we developed or customized has Copyright (c) 2020 Getflutter.

import 'dart:async';
import 'package:flutter/material.dart';

/// 縦長カルーセル
///
/// 参考元
/// <https://github.com/ionicfirebaseapp/getflutter/blob/master/lib/components/carousel/gf_items_carousel.dart>

typedef GFItemsCarouselSlideStartCallback = void Function(
    DragStartDetails details);

typedef GFItemsCarouselSlideCallback = void Function(DragUpdateDetails details);

typedef GFItemsCarouselSlideEndCallback = void Function(DragEndDetails details);

class GFRectItemsCarousel extends StatefulWidget {
  const GFRectItemsCarousel(
      {Key key,
      this.height,
      this.rowCount,
      this.children,
      this.onSlideStart,
      this.onSlide,
      this.onSlideEnd})
      : super(key: key);

  final int height;
  final int rowCount;
  final List<Widget> children;
  final GFItemsCarouselSlideStartCallback onSlideStart;
  final GFItemsCarouselSlideCallback onSlide;
  final GFItemsCarouselSlideEndCallback onSlideEnd;

  @override
  _GFRectItemsCarouselState createState() => _GFRectItemsCarouselState();
}

class _GFRectItemsCarouselState extends State<GFRectItemsCarousel>
    with TickerProviderStateMixin {
  static const int dragAnimationDuration = 1000;
  static const int shiftAnimationDuration = 300;
  // modified
  Size size = const Size(0, 0);
  double width = 0;
  double height;
  AnimationController animationController;
  double offset;

  @override
  void initState() {
    offset = 0;
    animationController = AnimationController(
      duration: const Duration(milliseconds: dragAnimationDuration),
      vsync: this,
    );
    Future.delayed(Duration.zero, () {
      setState(() {
        final localWidth = MediaQuery.of(context).size.width;
        width = localWidth;
        size =
            Size(width / widget.rowCount, height /* width / widget.rowCount */);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  double calculateOffset(double shift) {
    var localOffset = offset + shift;
    final rightLimit = size.width * (widget.children.length - widget.rowCount);

    /// Check cells container limits
    if (localOffset > 0) {
      localOffset = 0;
    } else if (localOffset < -rightLimit) {
      localOffset = -rightLimit;
    }
    return localOffset;
  }

  void onSlideStart(DragStartDetails details) {
    animationController.stop();
    if (widget.onSlideStart != null) {
      widget.onSlideStart(details);
    }
  }

  void onSlide(DragUpdateDetails details) {
    setState(() {
      offset = calculateOffset(3 * details.delta.dx);
    });
    if (widget.onSlide != null) {
      widget.onSlide(details);
    }
  }

  void onSlideEnd(DragEndDetails details) {
    final dx = details.velocity.pixelsPerSecond.dx;

    if (dx == 0) {
      return slideAnimation();
    }

    animationController = AnimationController(
      duration: const Duration(milliseconds: dragAnimationDuration),
      vsync: this,
    );

    final Tween tween =
        Tween<double>(begin: offset, end: calculateOffset(0.5 * dx));
    Animation animation;
    animation = tween.animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          slideAnimation();
        }
      })
      ..addListener(() {
        setState(() {
          offset = animation.value;
        });
      });

    animationController.forward();
    if (widget.onSlideEnd != null) {
      widget.onSlideEnd(details);
    }
  }

  void slideAnimation() {
    final beginAnimation = offset;
    final endAnimation = size.width * (offset / size.width).round().toDouble();
    animationController = AnimationController(
      duration: const Duration(milliseconds: shiftAnimationDuration),
      vsync: this,
    );
    final tween = Tween<double>(begin: beginAnimation, end: endAnimation);
    final animation = tween.animate(animationController);
    animation.addListener(() {
      setState(() {
        offset = animation.value;
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragStart: onSlideStart,
        onHorizontalDragUpdate: onSlide,
        onHorizontalDragEnd: onSlideEnd,
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                left: offset,
                child: Row(
                  children: widget.children
                      .map((child) => Container(
                            width: size.width,
                            height: size.height,
                            child: child,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
