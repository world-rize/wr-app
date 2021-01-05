import 'package:flutter/material.dart';
import 'package:wr_app/domain/system/model/announcement.dart';

class AnnouncementNotifier with ChangeNotifier {
  AnnouncementNotifier._internal();
  
  final List<Announcement> _dummyAnnouncements = [
    Announcement(
        title: 'WR英会話 β版のユーザーデータについて',
        content: '''
WR英会話 β verをDLしていただきありがとうございます。
⚠重要なお知らせです。
β verの情報はすべて削除させて頂きますのでご了承ください(WR Coinも含みます)
正式verに関する最新情報は弊社のインスタグラムをご確認ください(worldrizeで検索)''',
        createdAt: DateTime.parse('2021-01-05'),
    ),
    Announcement(
      title: 'WR英会話とは',
      content: '''
WR英会話 β verをDLしていただきありがとうございます。
このアプリは現役留学生が制作する「留学×英会話アプリ」です。
β verは一時的に機能を英会話アプリのみリリースしていますが、
α ver以降は現役留学生に留学相談できるサービスも開始する予定です。
是非多くの方々にご利用していただきたいので応援、拡散の方よろしくお願いします！''',
      createdAt: DateTime.parse('2021-01-03'),
    )
  ];

  factory AnnouncementNotifier() {
    return _cache ??= AnnouncementNotifier._internal();
  }

  /// singleton
  static AnnouncementNotifier _cache;
  
  Future<List<Announcement>> getAnnouncements() async {
    await Future.delayed(const Duration(seconds: 1));

    return _dummyAnnouncements;
  }
}