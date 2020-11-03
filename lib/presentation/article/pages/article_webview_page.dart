// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wr_app/domain/article/index.dart';

class MyInAppBrowser extends InAppBrowser {}

class ArticleWebViewPage extends StatefulWidget {
  ArticleWebViewPage({
    @required this.articleDigest,
  });

  ArticleDigest articleDigest;

  @override
  _ArticleWebViewPageState createState() =>
      _ArticleWebViewPageState(articleDigest: articleDigest);
}

class _ArticleWebViewPageState extends State<ArticleWebViewPage> {
  _ArticleWebViewPageState({@required this.articleDigest});

  ArticleDigest articleDigest;
  InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(articleDigest.fields.toJson());

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "InAppBrowser",
      )),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            if (articleDigest.fields.url == null)
//              Placeholder(
//                fallbackHeight: 200,
//              )
//            else
            Expanded(
              child: InAppWebView(
                initialUrl: articleDigest.fields.url ?? 'https://flutter.dev/',
                //          initialHeaders: {},
                //          initialOptions: InAppWebViewGroupOptions(
                //              crossPlatform: InAppWebViewOptions(
                //                debuggingEnabled: true,
                //              )
                //          ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                //          onLoadStart: (InAppWebViewController controller, String url) {
                //            setState(() {
                //              this.url = url;
                //            });
                //          },
                //          onLoadStop: (InAppWebViewController controller, String url) async {
                //            setState(() {
                //              this.url = url;
                //            });
                //          },
                //          onProgressChanged: (InAppWebViewController controller, int progress) {
                //            setState(() {
                //              this.progress = progress / 100;
                //            });
                //          },
              ),
            )
          ],
        ),
      ),
    );
  }
}
