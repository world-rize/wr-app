import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    final un = Provider.of<UserNotifier>(context);

    final b = Theme.of(context).primaryTextTheme.bodyText1;
    final h = Theme.of(context).primaryTextTheme.headline3;

    final upgradeButton = PrimaryButton(
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 100),
        child: Text(
          I.of(context).referFriendsUpgradeButton,
          style: TextStyle(fontSize: 20),
        ),
      ),
      onPressed: null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).referFriendsTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8).add(EdgeInsets.only(bottom: 90)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '友達紹介',
                      style: h,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text:
                                '友達紹介でWR CoinsをGET！\n\n友達がアプリをグレードアップするときにあなたの招待IDを入れると紹介者に1000 WR Coins、紹介された方には500 WR Coinsプレゼント！\n\n友達と一緒にWR英会話で勉強しよう！',
                            style: b,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'あなたの招待コード',
                      style: h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final data = ClipboardData(text: un.user.userId);
                        await Clipboard.setData(data);
                        InAppLogger.debug(
                            'copied ${un.user.userId} to clipboard');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                '${un.user.userId}',
                                style: h,
                              ),
                              const Icon(
                                FontAwesome5.clipboard,
                                color: Colors.grey,
                              ),
                            ],
                          ).padding(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '注意事項',
                      style: h,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text: '※ご不明な点がありましたら、',
                            style: b,
                          ),
                          TextSpan(
                            text: 'FAQ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(env.faqUrl)) {
                                  await launch(
                                    env.faqUrl,
                                    forceSafariVC: false,
                                    forceWebView: false,
                                  );
                                }
                              },
                            style: b.apply(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: 'の「友達紹介について」をご参照ください',
                            style: b,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
