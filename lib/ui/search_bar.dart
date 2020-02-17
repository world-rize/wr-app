// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

// search bar
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Phrase',
        ),
      ),
    );
  }
}
