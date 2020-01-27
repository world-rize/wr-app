import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/ui/lesson/section_select.dart';

//Widget _createSwiperView() {
//  return Flexible(
//    child: SizedBox(
//      // width: 200.0,
//      height: 300.0,
//      child: Swiper(
//        itemBuilder: (BuildContext context, int index) {
//          return new Image.network(
//            "http://via.placeholder.com/200x300",
//            fit: BoxFit.contain,
//          );
//        },
//        itemCount: 5,
//      ),
//    ),
//  );
//}


// 下線付きの見出しを作成
Widget _createHeadline(BuildContext context, Color lineColor, String title, [String subtitle = ""]) {
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
        // Lesson
        _createHeadline(context, Colors.blue, "Lesson", "There are 15 types in all."),

        CupertinoButton(
          child: Text("School"),
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => SectionSelectPage()),
          )
        ),

        // TODO: swipe view
        const Placeholder(fallbackHeight: 300.0,),

        // Favorite Section
        _createHeadline(context, Colors.red, "Favorite"),
        // TODO: favorite section
        const Placeholder(fallbackHeight: 100.0,),

        // New Coming Phrases Section
        _createHeadline(context, Colors.lightGreen, "New coming phrases"),
        // TODO: New Coming Phrases
        const Placeholder(fallbackHeight: 100.0,),

        // Request Section
        _createHeadline(context, Colors.red, "Request"),
        // TODO: Request
        const Placeholder(fallbackHeight: 150.0,),
      ],
    );
  }
}
