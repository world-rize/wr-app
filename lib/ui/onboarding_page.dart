// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:wr_app/ui/root_view.dart';

List<PageModel> _createOnBoardingPages(BuildContext context) {
  return [
    PageModel(
      color: const Color(0xFF678FB4),
      heroAssetPath: 'assets/wr_icon.jpg',
      title: Text('OnBoarding 1'),
      body: Text('page 1'),
      iconAssetPath: 'assets/wr_icon.jpg',
    ),
    PageModel(
      color: const Color(0xFF65B0B4),
      heroAssetPath: 'assets/wr_icon.jpg',
      title: Text('OnBoarding 2'),
      body: Text('page 2'),
      iconAssetPath: Icons.call.,
    ),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/wr_icon.jpg',
      title: Text('OnBoarding 3'),
      body: Text('page 3'),
      iconAssetPath: 'assets/wr_icon.jpg',
    ),
  ];
}

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: 'Done',
        skipButtonText: 'Skip',
        pageList: _createOnBoardingPages(context),
        onDoneButtonPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RootView()), (route) => false);
        },
        onSkipButtonPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RootView()), (route) => false);
        },
      ),
    );
  }
}
