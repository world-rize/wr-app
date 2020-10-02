// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnglishLessonPrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Image.asset('assets/thumbnails/affiliate.png');
    const onlineLessonsUrl = 'https://world-rize.com/category/online-lessons/';
    const affiliateUrl =
        'https://px.a8.net/svt/ejp?a8mat=3BG371+6C11GY+2QPM+61JSI';

    final affiliate = Stack(
      children: [
        image,
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(top: 350),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            textTheme: Theme.of(context).buttonTheme.textTheme,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Text(
              '無料体験する',
              style: Theme.of(context).textTheme.headline5,
            ),
            onPressed: () async {
              if (await canLaunch(affiliateUrl)) {
                await launch(
                  // TODO: iosで指定されているデフォルトブラウザで開けるのか
                  affiliateUrl,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              }
            },
          ),
        )
      ],
    );
    final onlineLessons = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              '''現役留学生が実際にオンライン英会話を試してメリットや体験談をHPで公開しています。
無料で体験レッスンが可能なのでまずはトライしてみましょう！
詳しくはこちらから''',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              textTheme: Theme.of(context).buttonTheme.textTheme,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Text(
                'オンライン英会話へ',
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () async {
                if (await canLaunch(onlineLessonsUrl)) {
                  await launch(
                    // TODO: iosで指定されているデフォルトブラウザで開けるのか
                    onlineLessonsUrl,
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            affiliate,
            onlineLessons,
          ],
        ),
      ),
    );
  }
}
