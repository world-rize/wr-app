// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

class Voice {
  Voice({this.title, this.path, this.exist});

  String title;
  String path;
  bool exist;
}

Future<bool> existAssets(String path) async {
  return rootBundle.load(path).then((_) => true).catchError((_) => false);
}

class AllPhrasesPage extends StatefulWidget {
  const AllPhrasesPage({this.filter});
  final bool Function(Phrase) filter;

  @override
  _AllPhrasesPageState createState() => _AllPhrasesPageState();
}

class _AllPhrasesPageState extends State<AllPhrasesPage> {
  Future<List<Voice>> paths() async {
    final notifier = Provider.of<LessonNotifier>(context);
    final voices = await Future.wait(notifier.phrases.expand((phrase) {
      return phrase.voicePaths().map((path) async {
        final exist = await existAssets('assets/$path');
        return Voice(path: 'assets/$path', title: '', exist: exist);
      });
    }));
    print('${voices.length} voices');

    return voices.where((v) => v.exist).toList();
  }

  @override
  Widget build(BuildContext context) {
    final voices = paths();

    return Scaffold(
      appBar: AppBar(
        title: Text('voice check'),
      ),
      body: FutureBuilder<List<Voice>>(
        future: voices,
        builder: (c, ss) {
          return ListView.builder(
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.all(8),
              child: ShadowedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ss.data[i].path,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            itemCount: ss.hasData ? ss.data.length : 0,
          );
        },
      ),
    );
  }
}
