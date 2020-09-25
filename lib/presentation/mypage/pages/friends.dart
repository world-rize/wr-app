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
import 'package:wr_app/presentation/mypage/pages/input_introducer.dart';
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

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(I.of(context).referFriendsTitle),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: Text(
                  '友達紹介',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: Text(
                  '友達紹介でWR CoinsをGET！\n\n友達がアプリをグレードアップするときにあなたの招待IDを入れると紹介者に1000 WR Coins、紹介された方には500 WR Coinsプレゼント！\n\n友達と一緒にWR英会話で勉強しよう！',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: Text(
                  'あなたの招待コード',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final data = ClipboardData(text: un.user.userId);
                  await Clipboard.setData(data);
                  InAppLogger.debug('copied ${un.user.userId} to clipboard');
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          '${un.user.userId}',
                          style: Theme.of(context).primaryTextTheme.headline3,
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
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: Text(
                  '注意事項',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text.rich(
                  TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: '※ご不明な点がありましたら、',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      TextSpan(
                        text: 'FAQ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch(env.privacyPolicyJaUrl)) {
                              await launch(
                                env.privacyPolicyJaUrl,
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            }
                          },
                        style:
                            Theme.of(context).primaryTextTheme.bodyText1.apply(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                      ),
                      TextSpan(
                        text: 'の「友達紹介について」をご参照ください',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrangeAccent,
          isExtended: true,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => InputIntroducerPage()));
          },
          label: Text(I.of(context).referFriendsUpgradeButton),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
