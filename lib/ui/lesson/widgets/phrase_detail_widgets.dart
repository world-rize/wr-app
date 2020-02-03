// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

Widget PhraseDetailSample() {
  // TODO: implement
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: <Widget>[
          const ListTile(
            title: Text(
              'タイトル',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Placeholder(fallbackHeight: 80),
                );
              },
              itemCount: 3,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget PhraseDetailChoices() {
  // TODO: implement
  return SizedBox(
    height: 350,
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Placeholder(fallbackHeight: 65),
            ),
          );
        },
        itemCount: 4),
  );
}
