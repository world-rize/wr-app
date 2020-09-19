// Copyright © 2020 WorldRIZe. All rights reserved.

//Future<void> fillText(FlutterDriver driver, String key, String text) async {
//  final finder = find.byValueKey(key);
//  await driver.waitFor(finder);
//  await driver.tap(finder);
//  await driver.enterText(text);
//  print('Enter $key to $text');
//}
//
//void main() {
//  group('App OnBoarding', () {
//    FlutterDriver driver;
//
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//
//    test('sign_up Test', () async {
//      await driver.tap(find.byValueKey('to_sign_up_button'));
//
//      await fillText(driver, 'name', 'test');
//      await fillText(driver, 'email', 'c@d.com');
//      await fillText(driver, 'password', '123456');
//      await fillText(driver, 'password_confirm', '123456');
//      await driver.tap(find.byValueKey('agree'));
//
//      await driver.tap(find.byValueKey('sign_up_button'));
//    });
//  });
//}
