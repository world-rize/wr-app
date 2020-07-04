// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:wr_app/store/logger.dart';
import 'package:wr_app/store/system.dart';

/// フィードバックを送信
Future<void> sendFeedback({String text}) async {
  final address = SystemStore().env['FEEDBACK_MAIL_ADDRESS'];

  print('email: $address');

  final email = Email(
    body: text,
    subject: 'WorldRIZe feedback',
    recipients: [address],
    attachmentPaths: [],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
    InAppLogger.log('send feedback', type: 'api');
  } catch (error) {
    InAppLogger.log('error: ${error.toString()}', type: 'api');
  }
}

/// リクエストを送信
Future<void> sendPhraseRequest({String text}) async {
  final address = SystemStore().env['FEEDBACK_MAIL_ADDRESS'];

  print('email: $address');

  final email = Email(
    body: text,
    subject: 'WorldRIZe phrase request',
    recipients: [address],
    attachmentPaths: [],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
    InAppLogger.log('send phrase request', type: 'api');
  } catch (error) {
    InAppLogger.log('error: ${error.toString()}', type: 'api');
  }
}
