//// Copyright © 2020 WorldRIZe. All rights reserved.
//
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:wr_app/domain/user/index.dart';
//
///// mypage > index > Achieved List
/////
///// - ノートにつけられた Achieved の一覧
//class AchievedListPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final userNotifier = Provider.of<UserNotifier>(context);
//    final user = userNotifier.getUser();
//
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Achieved List'),
//      ),
//      body: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            const Text('Achieved'),
//            ...user.notes.values
//                .expand(
//                    (note) => note.phrases.where((phrase) => phrase.achieved))
//                .map((phrase) => Text('${phrase.word} ${phrase.translation}'))
//                .toList(),
//          ],
//        ),
//      ),
//    );
//  }
//}
