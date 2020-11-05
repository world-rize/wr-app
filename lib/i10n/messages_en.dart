// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(point) => "${point} coins Get!";

  static m1(count, all) => "Clear [${count}/${all}]";

  static m2(membership) => "${Intl.select(membership, {'normal': 'FREE', 'pro': 'PRO', })}";

  static m3(point) => "${point} coins";

  static m4(q) => "Question ${q}";

  static m5(name) => "Would you like to register ${name} as an introducer?";

  static m6(name) => "10000 points were sent to ${name}. I got 500 points";

  static m7(clear) => "${Intl.select(clear, {'true': 'cleared', 'false': 'uncleared', })}";

  static m8(title, price) => "Would you like to buy ${title} with ${price} coins?";

  static m9(title) => "Do you want to start testing ${title}?";

  static m10(limit) => "Today\'s test remaining ${limit} times";

  static m11(questions, corrects) => "${questions} Questions ${corrects} Questions Correct!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "answerQuestionnaire" : MessageLookupByLibrary.simpleMessage("Answer the questionnaire!"),
    "appVersion" : MessageLookupByLibrary.simpleMessage("App Version"),
    "articleNotFoundMessage" : MessageLookupByLibrary.simpleMessage("No article exists"),
    "bottomNavAgency" : MessageLookupByLibrary.simpleMessage("Agency"),
    "bottomNavColumn" : MessageLookupByLibrary.simpleMessage("Columns"),
    "bottomNavLesson" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "bottomNavMyPage" : MessageLookupByLibrary.simpleMessage("My page"),
    "bottomNavNote" : MessageLookupByLibrary.simpleMessage("Note"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeButtonText" : MessageLookupByLibrary.simpleMessage("Change"),
    "close" : MessageLookupByLibrary.simpleMessage("閉じる"),
    "currentPasswordHintText" : MessageLookupByLibrary.simpleMessage("Current password"),
    "darkMode" : MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "doNotEmptyMessage" : MessageLookupByLibrary.simpleMessage("Do not empty"),
    "emailHintText" : MessageLookupByLibrary.simpleMessage("Email"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "errorInvalidEmail" : MessageLookupByLibrary.simpleMessage("Your email address appears to be malformed."),
    "errorOperationNotAllowed" : MessageLookupByLibrary.simpleMessage("Signing in with Email and Password is not enabled."),
    "errorTooManyRequests" : MessageLookupByLibrary.simpleMessage("Too many requests. Try again later."),
    "errorUndefinedError" : MessageLookupByLibrary.simpleMessage("An undefined Error happened."),
    "errorUserDisabled" : MessageLookupByLibrary.simpleMessage("User with this email has been disabled."),
    "errorUserNotFound" : MessageLookupByLibrary.simpleMessage("User with this email doesn\'t exist."),
    "errorWrongPassword" : MessageLookupByLibrary.simpleMessage("Your password is wrong."),
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "favoritePageTitle" : MessageLookupByLibrary.simpleMessage("Favorites"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "getPoints" : m0,
    "havingCoin" : MessageLookupByLibrary.simpleMessage("Coins you have"),
    "homepage" : MessageLookupByLibrary.simpleMessage("World RIZe Website"),
    "invalidPasswordMessage" : MessageLookupByLibrary.simpleMessage("Please enter the password with at least 6 characters"),
    "lessonPageTitle" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "lessonSearchAppBarTitle" : MessageLookupByLibrary.simpleMessage("Search"),
    "lessonSearchHintText" : MessageLookupByLibrary.simpleMessage("Words etc."),
    "lessonStatus" : m1,
    "license" : MessageLookupByLibrary.simpleMessage("License"),
    "memberStatus" : m2,
    "myPageInfoButton" : MessageLookupByLibrary.simpleMessage("Annoucements"),
    "myPageInfoNotFound" : MessageLookupByLibrary.simpleMessage("There is no notification"),
    "myPageReferFriendsButton" : MessageLookupByLibrary.simpleMessage("Refer Friends"),
    "myPageShopButton" : MessageLookupByLibrary.simpleMessage("Shop"),
    "myPageUpgradeButton" : MessageLookupByLibrary.simpleMessage("Upgrade"),
    "nameHintText" : MessageLookupByLibrary.simpleMessage("Name"),
    "newComingPageTitle" : MessageLookupByLibrary.simpleMessage("New Coming Phrases"),
    "newPasswordHintText" : MessageLookupByLibrary.simpleMessage("New Password (6 characters or more)"),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noNewComingPhraseMessage" : MessageLookupByLibrary.simpleMessage("No new coming phrases"),
    "noteList" : MessageLookupByLibrary.simpleMessage("Note List"),
    "notifications" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onePointAdvice" : MessageLookupByLibrary.simpleMessage("One Point Advice"),
    "passwordConfirmHintText" : MessageLookupByLibrary.simpleMessage("Password confirmation"),
    "passwordHintText" : MessageLookupByLibrary.simpleMessage("Password (6 characters or more)"),
    "phraseDetailTitle" : MessageLookupByLibrary.simpleMessage("Phrase Detail"),
    "points" : m3,
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "question" : m4,
    "readMore" : MessageLookupByLibrary.simpleMessage("Read more"),
    "referFriendsConfirmDialog" : m5,
    "referFriendsIntroduceeIDInputTitle" : MessageLookupByLibrary.simpleMessage("Enter the referrer\'s ID"),
    "referFriendsNotFound" : MessageLookupByLibrary.simpleMessage("User not found"),
    "referFriendsSearchButton" : MessageLookupByLibrary.simpleMessage("Search"),
    "referFriendsSuccessDialog" : m6,
    "referFriendsTitle" : MessageLookupByLibrary.simpleMessage("Refer Friends"),
    "referFriendsUpgradeButton" : MessageLookupByLibrary.simpleMessage("Upgrade with a friend\'s referral"),
    "referFriendsUserIdHintText" : MessageLookupByLibrary.simpleMessage("User ID"),
    "referFriendsYourID" : MessageLookupByLibrary.simpleMessage("Your ID"),
    "requestPageTitle" : MessageLookupByLibrary.simpleMessage("Request"),
    "requestPhrase" : MessageLookupByLibrary.simpleMessage("Request a new phrase"),
    "requestPhraseButton" : MessageLookupByLibrary.simpleMessage("Request a new phrase"),
    "sectionStatus" : m7,
    "sendPhraseRequest" : MessageLookupByLibrary.simpleMessage("Send a request"),
    "sendRequestButton" : MessageLookupByLibrary.simpleMessage("Send"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shopPageConfirmDialog" : m8,
    "shopPagePurchase" : MessageLookupByLibrary.simpleMessage("Purchase"),
    "shopPageSuccess" : MessageLookupByLibrary.simpleMessage("The exchange has been confirmed. We will send the gift code to the registered email address within 2 weeks"),
    "show30DaysChallengeAchievedDialogTitle" : MessageLookupByLibrary.simpleMessage("Achieved 30 Days Challenge"),
    "signInButton" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "signInMessage" : MessageLookupByLibrary.simpleMessage("Click here if you already have an account"),
    "signInSuccessful" : MessageLookupByLibrary.simpleMessage("logged in successfully"),
    "signUpButton" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "signUpMessage" : MessageLookupByLibrary.simpleMessage("The first one here"),
    "termsOfService" : MessageLookupByLibrary.simpleMessage("Terms of service"),
    "testClear" : MessageLookupByLibrary.simpleMessage("Test Clear!"),
    "testConfirm" : m9,
    "testInterrupt" : MessageLookupByLibrary.simpleMessage("Do you want to interrupt the test?"),
    "testInterruptDetail" : MessageLookupByLibrary.simpleMessage("If you interrupt the test, this test will be 0 points, and the number of times you can take the test per day will be consumed once."),
    "testLimitAlert" : MessageLookupByLibrary.simpleMessage("I can\'t take any more tests today"),
    "testLimitAlertDetail" : MessageLookupByLibrary.simpleMessage("You can take the test up to 3 times a day"),
    "testMessage" : m10,
    "testScore" : m11,
    "topPage" : MessageLookupByLibrary.simpleMessage("Go to the top page"),
    "userPageTitle" : MessageLookupByLibrary.simpleMessage("User page"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
