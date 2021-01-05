// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/widgets/announcement_list.dart';

/// mypage > index > AnnouncementPage
class AnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageInfoButton),
      ),
      body: AnnouncementList(),
    );
  }
}
