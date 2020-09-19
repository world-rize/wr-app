import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icon/maintenance.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              left: 10,
              bottom: 40,
              child: Text(
                'Under Maintenance...',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
