// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/article/index.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({this.category, this.onTap});

  final ArticleCategory category;
  final Function(ArticleCategory) onTap;

  @override
  Widget build(BuildContext context) {
    final h1 = Theme.of(context).primaryTextTheme.headline1;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          onTap(category);
        },
        child: Container(
          constraints: const BoxConstraints.expand(height: 170),
          padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(category.thumbnailUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              // title
              Positioned(
                left: 0,
                top: 10,
                child: Text(
                  category.title,
                  style: h1.apply(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
