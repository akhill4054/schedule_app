import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(40),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Signing In..',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/calendar.json',
                  width: 300,
                ),
                Text(
                  'Please wait while we log you in...',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
