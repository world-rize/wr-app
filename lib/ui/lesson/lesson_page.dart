import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/ui/lesson/section_select.dart';
import 'package:getflutter/getflutter.dart';

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class LessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            GFTypography(
              text: 'Hello, World',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.primary,
            ),
            //

            GFItemsCarousel(
              rowCount: 3,
              children: imageList.map(
                (url) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SectionSelectPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(url,
                                fit: BoxFit.cover, width: 500),
                          ),
                          Center(
                            child: GFTypography(
                              text: 'Hello',
                              textColor: Colors.white,
                              showDivider: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),

            GFTypography(
              text: 'Favorite',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.danger,
            ),

            const Placeholder(
              fallbackHeight: 100.0,
            ),

            // New Coming Phrases Section
            GFTypography(
              text: 'New coming phrases',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.success,
            ),

            // TODO: New Coming Phrases
            const Placeholder(
              fallbackHeight: 100.0,
            ),

            // Request Section
            GFTypography(
              text: 'Request',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.secondary,
            ),
            // TODO: Request
            const Placeholder(
              fallbackHeight: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
