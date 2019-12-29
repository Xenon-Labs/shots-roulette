import 'package:flutter/material.dart';

class GameSession extends StatefulWidget {
  GameSession({Key key, @required this.horizontalShotsNum}) : super (key: key);

  final int horizontalShotsNum;

  @override
  _GameSessionState createState() => _GameSessionState();
}

class _GameSessionState extends State<GameSession> with
    TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration:
    Duration(milliseconds: 300));

  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedIcon(icon: AnimatedIcons.arrow_menu,
            progress: _animationController),
          RaisedButton(
              onPressed: () => _handleOnPressed(),
          )
        ],
      )),

    );
  }
}
