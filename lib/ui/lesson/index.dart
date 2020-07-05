// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/favorite_page.dart';
import 'package:wr_app/ui/lesson/request_page.dart';
import 'package:wr_app/ui/lesson/widgets/lesson_select_carousel.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

/// `レッスン` ページのトップ
///
class LessonIndexPage extends StatelessWidget {
  Future<void> _sendAnalyticsEvent(BuildContext context) async {
    final userStore = Provider.of<UserStore>(context);
    if (userStore == null) {
      return;
    }
    final analytics = Provider.of<FirebaseAnalytics>(context);
    await analytics.logEvent(
      name: 'test_event',
      parameters: {
        'uid': userStore.user.uuid,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final masterData = Provider.of<MasterDataStore>(context);

    final favoritePhrase = masterData.allPhrases().firstWhere(
        (phrase) =>
            userStore.user.favorites.containsKey(phrase.id) &&
            userStore.user.favorites[phrase.id],
        orElse: () => null);

    // TODO(someone): call api
    final newComingPhrase = masterData
        .allPhrases()
        .firstWhere((phrase) => phrase.id.endsWith('5'), orElse: () => null);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const GFTypography(
            text: 'Lesson',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.PRIMARY,
          ),

          // TODO(someone): fix LessonSelectCarousel
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: LessonSelectCarousel(),
          ),

          const GFTypography(
            text: 'Favorite',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.DANGER,
          ),

          if (favoritePhrase != null)
            Column(
              children: [
                PhraseCard(
                  phrase: favoritePhrase,
                  favorite: userStore.favorited(favoritePhrase),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => FavoritePage()),
                    );
                  },
                ),
              ],
            )
          else
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('no favorites',
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
            ),

          // New Coming Phrases Section
          const GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ),

          if (newComingPhrase != null)
            Column(
              children: [
                PhraseCard(
                  phrase: newComingPhrase,
                  favorite: userStore.favorited(newComingPhrase),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => FavoritePage()),
                    );
                  },
                ),
              ],
            )
          else
            const Text('no newcomming'),

          // Request Section
          const GFTypography(
            text: 'Request',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SECONDARY,
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RequestPage()),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 90),
                child: Text(I.of(context).requestPhraseButton),
              ),
            ),
          ).p_1(),
        ],
      ).p_1(),
    );
  }
}
