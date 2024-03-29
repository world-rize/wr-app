// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

class RewardDialog extends StatelessWidget {
  const RewardDialog({this.text, this.onTap});

  final Widget text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(I.of(context).testClear),
      content: Column(
        children: <Widget>[
          text,
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            label: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(I.of(context).answerQuestionnaire)),
            onPressed: () async {
              final systemNotifier = Provider.of<SystemNotifier>(
                context,
                listen: false,
              );
              final env = DotEnv().env;
              final questionnaireUrl = env['QUESTIONNAIRE_URL'];
              systemNotifier.setQuestionnaireAnswered(value: true);
              if (await canLaunch(questionnaireUrl)) {
                await launch(
                  questionnaireUrl,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            label: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(I.of(context).close)),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
