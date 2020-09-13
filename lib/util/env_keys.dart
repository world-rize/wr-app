// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

class EnvKeys {
  final String contentfulSpaceId;
  final String contentfulToken;
  final String admobAppId;
  final bool useEmulator;
  final String functionsEmulatorOrigin;
  final String sentryDsn;
  final String requestMailAddress;
  final String giftMailAddress;
  final String questionnaireUrl;
  final String termsOfServiceUtl;
  final String privacyPolicyUrl;
  final String faqUrl;
  final String contactUrl;
  final String homePageUrl;
  final String twitterUrl;
  final String instagramUrl;

  EnvKeys({
    @required this.contentfulSpaceId,
    @required this.contentfulToken,
    @required this.admobAppId,
    @required this.useEmulator,
    @required this.functionsEmulatorOrigin,
    @required this.sentryDsn,
    @required this.requestMailAddress,
    @required this.giftMailAddress,
    @required this.questionnaireUrl,
    @required this.termsOfServiceUtl,
    @required this.privacyPolicyUrl,
    @required this.faqUrl,
    @required this.contactUrl,
    @required this.homePageUrl,
    @required this.twitterUrl,
    @required this.instagramUrl,
  });

  factory EnvKeys.fromEnv({
    @required Map<String, String> env,
  }) {
    assert(env.containsKey('CONTENTFUL_SPACE_ID'));
    assert(env.containsKey('CONTENTFUL_TOKEN'));
    assert(env.containsKey('ADMOB_APP_ID'));
    assert(env.containsKey('USE_EMULATOR'));
    assert(env.containsKey('FUNCTIONS_EMULATOR_ORIGIN'));
    assert(env.containsKey('SENTRY_DSN'));
    assert(env.containsKey('REQUEST_MAIL_ADDRESS'));
    assert(env.containsKey('GIFT_MAIL_ADDRESS'));
    assert(env.containsKey('QUESTIONNAIRE_URL'));
    assert(env.containsKey('TERMS_OF_SERVICE_URL'));
    assert(env.containsKey('PRIVACY_POLICY_URL'));
    assert(env.containsKey('FAQ_URL'));
    assert(env.containsKey('CONTACT_URL'));
    assert(env.containsKey('HOME_PAGE_URL'));
    assert(env.containsKey('TWITTER_URL'));
    assert(env.containsKey('INSTA_URL'));

    return EnvKeys(
      contentfulSpaceId: env['CONTENTFUL_SPACE_ID'],
      contentfulToken: env['CONTENTFUL_TOKEN'],
      admobAppId: env['ADMOB_APP_ID'],
      useEmulator: env[''] == 'true',
      functionsEmulatorOrigin: env['FUNCTIONS_EMULATOR_ORIGIN'],
      sentryDsn: env['SENTRY_DSN'],
      requestMailAddress: env['REQUEST_MAIL_ADDRESS'],
      giftMailAddress: env['GIFT_MAIL_ADDRESS'],
      questionnaireUrl: env['QUESTIONNAIRE_URL'],
      termsOfServiceUtl: env['TERMS_OF_SERVICE_URL'],
      privacyPolicyUrl: env['PRIVACY_POLICY_URL'],
      faqUrl: env['FAQ_URL'],
      contactUrl: env['CONTACT_URL'],
      homePageUrl: env['HOME_PAGE_URL'],
      twitterUrl: env['TWITTER_URL'],
      instagramUrl: env['INSTA_URL'],
    );
  }
}
