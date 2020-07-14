// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wr_app/domain/article/index.dart';

class ArticleWebViewPage extends StatelessWidget {
  ArticleWebViewPage({
    @required this.article,
  });

  ArticleDigest article;
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        child: InAppWebView(
          initialUrl: article.fields.url,
          initialHeaders: const {},
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
            debuggingEnabled: true,
          )),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
        ),
      ),
    );
  }
}
