import 'package:flutter/material.dart';
import 'package:shots_roulette/sharedWidgets/defaultRaisedButton.dart';

class DefaultDialog extends StatelessWidget {
  DefaultDialog({Key key, this.child, this.buttonText, this.buttonAction})
      : super(key: key);

  final Widget child;
  final String buttonText;
  final Function buttonAction;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            Padding(padding: EdgeInsets.all(10)),
            DefaultRaisedButton(
              onPressed: buttonAction,
              title: buttonText,
            )
          ],
        ),
      ),
    );
  }
}
