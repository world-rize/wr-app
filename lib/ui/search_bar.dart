import 'package:flutter/material.dart';

// search bar
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.all(
//                const Radius.circular(10.0),
//              ),
//            ),
          hintText: "Phrase",
        ),
      ),
    );
  }
}
