// Copyright © 2020 WorldRIZe. All rights reserved.

// MODIFIED FROM
// All the components that we developed or customized has Copyright (c) 2020 Getflutter.
// https://github.com/ionicfirebaseapp/getflutter/blob/master/lib/components/carousel/gf_items_carousel.dart

import 'dart:async';
import 'package:flutter/material.dart';

/// When a pointer has come to contact with screen and has begun to move.
///
/// The function provides the position of the touch when it first
/// touched the surface.
typedef GFItemsCarouselSlideStartCallback = void Function(
    DragStartDetails details);

/// When a pointer that is in contact with the screen and moving
/// has moved again.
///
/// The function provides the position of the touch and the distance it
/// has travelled since the last update.
typedef GFItemsCarouselSlideCallback = void Function(DragUpdateDetails details);

/// When a pointer that was previously in contact with the screen
/// and moving is no longer in contact with the screen.
///
/// The velocity at which the pointer was moving when it stopped contacting
/// the screen.
typedef GFItemsCarouselSlideEndCallback = void Function(DragEndDetails details);

class GFRectItemsCarousel extends StatefulWidget {
  /// Creates slide show of Images and [Widget] with animation for sliding.
  /// Shows multiple items on one slide, items number depends on rowCount.
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

  /// Count of visible cells
  final int rowCount;

  /// The widgets to be shown as sliders.
  final List<Widget> children;

  /// When a pointer has contacted the screen and has begun to move.
  final GFItemsCarouselSlideStartCallback onSlideStart;

  /// When a pointer that is in contact with the screen and moving
  /// has moved again.
  final GFItemsCarouselSlideCallback onSlide;

  /// When a pointer that was previously in contact with the screen
  /// and moving is no longer in contact with the screen.
  final GFItemsCarouselSlideEndCallback onSlideEnd;

  @override
  _GFRectItemsCarouselState createState() => _GFRectItemsCarouselState();
}

class _GFRectItemsCarouselState extends State<GFRectItemsCarousel>
    with TickerProviderStateMixin {
  /// In milliseconds
  static const int dragAnimationDuration = 1000;

  /// In milliseconds
  static const int shiftAnimationDuration = 300;

  /// Size of cell
  Size size = Size(0, 0);

  /// Width of cells container
  double width = 0;

  double height;

  AnimationController animationController;

  /// Shift of cells container
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
        final double localWidth = MediaQuery.of(context).size.width;
        width = localWidth;
        size =
            Size(width / widget.rowCount, height /* width / widget.rowCount */);
      });
    });
    super.initState();
  }

  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  double calculateOffset(double shift) {
    double localOffset = offset + shift;
    final double rightLimit =
        size.width * (widget.children.length - widget.rowCount);

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
    final double dx = details.velocity.pixelsPerSecond.dx;

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
    ));
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        slideAnimation();
      }
    });
    animation.addListener(() {
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
    final double beginAnimation = offset;
    final double endAnimation =
        size.width * (offset / size.width).round().toDouble();
    animationController = AnimationController(
      duration: const Duration(milliseconds: shiftAnimationDuration),
      vsync: this,
    );
    final Tween tween = Tween<double>(begin: beginAnimation, end: endAnimation);
    final Animation animation = tween.animate(animationController);
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
