import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/model/announcement.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/notifier/announcement_page_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

class AnnouncementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AnnouncementNotifier(),
      child: _AnnouncementList(),
    );
  }
}

class _AnnouncementList extends StatelessWidget {
  Widget _announcementView(BuildContext context, Announcement announcement) {
    final bg = Theme.of(context).backgroundColor;
    final titleStyle = Theme.of(context).primaryTextTheme.headline4;
    final contentStyle = Theme.of(context).primaryTextTheme.bodyText2;
    final dateStyle =
        Theme.of(context).primaryTextTheme.caption.apply(color: Colors.grey);

    return ShadowedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: titleStyle,
          ).padding(),
          Text(
            announcement.content,
            style: contentStyle,
          ).padding(),
          Text(
            I.of(context).dateFromNow(announcement.createdAt),
            style: dateStyle,
          ).padding(),
        ],
      ),
      color: bg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AnnouncementNotifier>(context);

    return SingleChildScrollView(
      child: FutureBuilder<List<Announcement>>(
        future: state.getAnnouncements(),
        builder: (ctx, ss) {
          if (!ss.hasData || ss.hasData && ss.data.isEmpty) {
            return Center(
              child: Text(
                I.of(context).myPageInfoNotFound,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            );
          }

          return Column(
            children:
                ss.data.map((e) =>
                    _announcementView(context, e).padding()
                ).toList(),
          );
        },
      ),
    );
  }
}
