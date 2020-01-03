import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

Widget _createSwiperView() {
  return Flexible(
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
  );
}

Widget _createLessonSelectView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CupertinoButton(
        color: Colors.blue,
        child: Text("ボタン"),
      )
    ],
  );
}

Widget _createHeadline(BuildContext context, Color lineColor, String title,
    [String subtitle = ""]) {
  var textTheme = Theme.of(context).textTheme;
  // TODO: partial bottom border
  var bottomBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 3.0, color: lineColor),
    ),
  );

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Container(
      decoration: bottomBorder,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(title, style: textTheme.display1.apply(color: Colors.black87)),
          SizedBox(
            width: 12.0,
          ),
          Text(
            subtitle,
            style: textTheme.title.apply(color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

class LessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _createHeadline(
            context, Colors.blue, "Lesson", "There are 15 types in all."),
        const Placeholder(
          fallbackHeight: 300.0,
        ),
        _createHeadline(context, Colors.red, "Favorite"),
        const Placeholder(
          fallbackHeight: 100.0,
        ),
        _createHeadline(context, Colors.lightGreen, "New coming phrases"),
        const Placeholder(
          fallbackHeight: 100.0,
        ),
        _createHeadline(context, Colors.red, "Request"),
        const Placeholder(
          fallbackHeight: 150.0,
        ),
      ],
    );
  }
}
