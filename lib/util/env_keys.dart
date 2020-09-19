// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:io';

import 'package:flutter/material.dart';

class EnvKeys {
  final String contentfulSpaceId;
  final String contentfulToken;
  final String admobIosAppId;
  final String admobAndroidAppId;
  final String admobIosBannerAdUnitId;
  final String admobAndroidBannerAdUnitId;
  final bool useEmulator;
  final String functionsEmulatorOrigin;
  final String sentryDsn;
  final String requestMailAddress;
  final String giftMailAddress;
  final String questionnaireUrl;
  final String termsOfServiceUtl;
  final String privacyPolicyJaUrl;
  final String privacyPolicyEuUrl;
  final String specifiedCommercialTransactionActUrl;
  final String faqUrl;
  final String contactUrl;
  final String homePageUrl;
  final String twitterUrl;
  final String instagramUrl;

  EnvKeys({
    @required this.contentfulSpaceId,
    @required this.contentfulToken,
    @required this.admobIosAppId,
    @required this.admobAndroidAppId,
    @required this.admobIosBannerAdUnitId,
    @required this.admobAndroidBannerAdUnitId,
    @required this.useEmulator,
    @required this.functionsEmulatorOrigin,
    @required this.sentryDsn,
    @required this.requestMailAddress,
    @required this.giftMailAddress,
    @required this.questionnaireUrl,
    @required this.termsOfServiceUtl,
    @required this.privacyPolicyJaUrl,
    @required this.privacyPolicyEuUrl,
    @required this.specifiedCommercialTransactionActUrl,
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
    assert(env.containsKey('ADMOB_IOS_APP_ID'));
    assert(env.containsKey('ADMOB_ANDROID_APP_ID'));
    assert(env.containsKey('ADMOB_IOS_BANNER_AD_UNIT_ID'));
    assert(env.containsKey('ADMOB_ANDROID_BANNER_AD_UNIT_ID'));
    assert(env.containsKey('USE_EMULATOR'));
    assert(env.containsKey('FUNCTIONS_EMULATOR_ORIGIN'));
    assert(env.containsKey('SENTRY_DSN'));
    assert(env.containsKey('REQUEST_MAIL_ADDRESS'));
    assert(env.containsKey('GIFT_MAIL_ADDRESS'));
    assert(env.containsKey('QUESTIONNAIRE_URL'));
    assert(env.containsKey('TERMS_OF_SERVICE_URL'));
    assert(env.containsKey('PRIVACY_POLICY_JA_URL'));
    assert(env.containsKey('PRIVACY_POLICY_EU_URL'));
    assert(env.containsKey('SPECIFIED_COMMERCIAL_TRANSACTION_ACT_URL'));
    assert(env.containsKey('FAQ_URL'));
    assert(env.containsKey('CONTACT_URL'));
    assert(env.containsKey('HOME_PAGE_URL'));
    assert(env.containsKey('TWITTER_URL'));
    assert(env.containsKey('INSTA_URL'));

    return EnvKeys(
      contentfulSpaceId: env['CONTENTFUL_SPACE_ID'],
      contentfulToken: env['CONTENTFUL_TOKEN'],
      admobIosAppId: env['ADMOB_IOS_APP_ID'],
      admobAndroidAppId: env['ADMOB_ANDROID_APP_ID'],
      admobIosBannerAdUnitId: env['ADMOB_IOS_BANNER_AD_UNIT_ID'],
      admobAndroidBannerAdUnitId: env['ADMOB_ANDROID_BANNER_AD_UNIT_ID'],
      useEmulator: env['USE_EMULATOR'] == 'true',
      functionsEmulatorOrigin: env['FUNCTIONS_EMULATOR_ORIGIN'],
      sentryDsn: env['SENTRY_DSN'],
      requestMailAddress: env['REQUEST_MAIL_ADDRESS'],
      giftMailAddress: env['GIFT_MAIL_ADDRESS'],
      questionnaireUrl: env['QUESTIONNAIRE_URL'],
      termsOfServiceUtl: env['TERMS_OF_SERVICE_URL'],
      privacyPolicyJaUrl: env['PRIVACY_POLICY_JA_URL'],
      privacyPolicyEuUrl: env['PRIVACY_POLICY_EU_URL'],
      specifiedCommercialTransactionActUrl:
          env['SPECIFIED_COMMERCIAL_TRANSACTION_ACT_URL'],
      faqUrl: env['FAQ_URL'],
      contactUrl: env['CONTACT_URL'],
      homePageUrl: env['HOME_PAGE_URL'],
      twitterUrl: env['TWITTER_URL'],
      instagramUrl: env['INSTA_URL'],
    );
  }

  String get admobAppId {
    if (Platform.isIOS) {
      return admobIosAppId;
    } else if (Platform.isAndroid) {
      return admobAndroidAppId;
    }
    return '';
  }

  String get admobBannerAdUnitId {
    if (Platform.isIOS) {
      return admobIosBannerAdUnitId;
    } else if (Platform.isAndroid) {
      return admobAndroidBannerAdUnitId;
    }
    return '';
  }
}
