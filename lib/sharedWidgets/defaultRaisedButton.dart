import 'package:flutter/material.dart';

class DefaultRaisedButton extends StatelessWidget {
  DefaultRaisedButton({Key key, this.title, @required this.onPressed}) : super
      (key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(title),
      onPressed: onPressed,
    );
  }
}
