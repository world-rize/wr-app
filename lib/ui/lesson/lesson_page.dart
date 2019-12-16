import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

Widget _createLessonSelectView() {
  return Row(
    children: <Widget>[
      Flexible(
        child: SizedBox(
          // width: 200.0,
          height: 300.0,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network(
                "http://via.placeholder.com/200x300",
                fit: BoxFit.contain,
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    ],
  );
}

class LessonPage extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'レッスン',
          style: optionStyle,
        ),
        _createLessonSelectView(),
      ],
    );
  }
}
