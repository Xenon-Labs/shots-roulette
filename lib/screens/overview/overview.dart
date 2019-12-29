import 'package:flutter/material.dart';
import 'package:shots_roulette/screens/gameSetting/gameSetting.dart';
import 'package:shots_roulette/sharedWidgets/defaultRaisedButton.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultRaisedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GameSetting())),
              title: "Play Now!",
            ),
            DefaultRaisedButton(
              onPressed: null,
              title: "How To Play?",
            )
          ],
        ),
      ),
    );
  }
}
