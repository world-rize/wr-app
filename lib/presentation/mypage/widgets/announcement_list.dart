import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/model/announcement.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/notifier/announcement_page_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

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
    final titleStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final contentStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return ShadowedContainer(
      child: Column(
        children: [
          Text(
            announcement.title,
            style: titleStyle,
          ),
          Text(
            announcement.content,
            style: contentStyle,
          ),
          Text(
            I.of(context).dateFromNow(announcement.createdAt),
            style: contentStyle.apply(color: Colors.grey),
          ),
        ],
      ),
      color: bg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AnnouncementNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<List<Announcement>>(
          future: state.getAnnouncements(),
          builder: (ctx, ss) {
            if (!ss.hasData || ss.hasData && ss.data.isEmpty) {
              return Center(
                child: Text(
                  I.of(context).myPageInfoNotFound,
                  style: const TextStyle(color: Colors.grey, fontSize: 24),
                ),
              );
            }

            if (ss.hasError) {
              return const Text('Error');
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: ss.data.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: _announcementView(context, ss.data[index]),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
