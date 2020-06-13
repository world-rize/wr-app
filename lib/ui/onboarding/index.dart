// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:wr_app/ui/onboarding/sign_in_view.dart';
import 'package:wr_app/ui/onboarding/sign_up_view.dart';

class OnBoardModal extends StatefulWidget {
  @override
  _OnBoardModalState createState() => _OnBoardModalState();
}

class _OnBoardModalState extends State<OnBoardModal> {
  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xff56c0ea);

    return IntroSlider(
      slides: [
        Slide(
          backgroundColor: splashColor,
          backgroundBlendMode: BlendMode.src,
          widgetTitle: const Text(
            'Sign up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          // pathImage: 'assets/icon/wr_icon.jpg',
          centerWidget: IntrinsicHeight(
            child: SignUpView(),
          ),
        ),
        Slide(
          backgroundColor: splashColor,
          backgroundBlendMode: BlendMode.src,
          widgetTitle: const Text(
            'Sign in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          // pathImage: 'assets/icon/wr_icon.jpg',
          centerWidget: IntrinsicHeight(
            child: SignInView(),
          ),
        ),
      ],
      isShowSkipBtn: false,
      isShowNextBtn: false,
      isShowDoneBtn: false,
    );
  }
}
