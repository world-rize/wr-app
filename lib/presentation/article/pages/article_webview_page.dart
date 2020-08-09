// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wr_app/domain/article/index.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(String url) async {
    print("\n\nStarted $url\n\n");
  }

  @override
  Future onLoadStop(String url) async {
    print("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(String url, int code, String message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(int progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }

  @override
  Future<ShouldOverrideUrlLoadingAction> shouldOverrideUrlLoading(
      ShouldOverrideUrlLoadingRequest shouldOverrideUrlLoadingRequest) async {
    print("\n\nOverride ${shouldOverrideUrlLoadingRequest.url}\n\n");
    return ShouldOverrideUrlLoadingAction.ALLOW;
  }

  @override
  void onLoadResource(LoadedResource response) {
    print("Started at: " +
        response.startTime.toString() +
        "ms ---> duration: " +
        response.duration.toString() +
        "ms " +
        response.url);
  }

  @override
  void onConsoleMessage(ConsoleMessage consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }
}

class ArticleWebViewPage extends StatefulWidget {
  ArticleWebViewPage({
    @required this.article,
  });

  ArticleDigest article;
  final browser = MyInAppBrowser();

  @override
  _ArticleWebViewPageState createState() => _ArticleWebViewPageState();
}

class _ArticleWebViewPageState extends State<ArticleWebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "InAppBrowser",
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: null,
//              onPressed: () async {
//                await widget.browser.openFile(
//                  assetFilePath: "assets/index.html",
//                  options: InAppBrowserClassOptions(
//                    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
//                      crossPlatform: InAppWebViewOptions(
//                        debuggingEnabled: true,
//                        useShouldOverrideUrlLoading: true,
//                        useOnLoadResource: true,
//                      ),
//                    ),
//                  ),
//                );
//              },
              child: Text("Open In-App Browser"),
            ),
            Container(height: 40),
            RaisedButton(
              onPressed: () async {
                await InAppBrowser.openWithSystemBrowser(
                    url: "https://flutter.dev/");
              },
              child: Text("Open System Browser"),
            ),
          ],
        ),
      ),
    );
  }
}
