import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shots_roulette/sharedWidgets/defaultDialog.dart';
import 'package:shots_roulette/sharedWidgets/defaultRaisedButton.dart';
import 'package:shots_roulette/screens/gameSession/gameSession.dart';

class GameSetting extends StatefulWidget {
  @override
  _GameSettingState createState() => _GameSettingState();
}

class _GameSettingState extends State<GameSetting> {
  int _currentIntValue;

  Decoration _decoration = new BoxDecoration(
    border: new Border(
      top: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
      bottom: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
    ),
  );

  @override
  void initState() {
    _currentIntValue = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "How many cups are you putting on the"
                " on the long side of your device?",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: NumberPicker.integer(
                    decoration: _decoration,
                    initialValue: _currentIntValue,
                    minValue: 1,
                    maxValue: 9,
                    step: 1,
                    onChanged: (value) =>
                        setState(() => _currentIntValue = value),
                  )),
              DefaultRaisedButton(
                  title: 'Ready to Go!',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameSession(
                                horizontalShotsNum: _currentIntValue)));
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return DefaultDialog(
                              child: Text(
                                "Fill shot cups with the spirits of your choice and place "
                                "it around your device, in the spots highlighted",
                                style: Theme.of(context).textTheme.headline2,
                                textAlign: TextAlign.center,
                              ),
                              buttonText: "Ready!",
                              buttonAction: () => Navigator.of(context).pop());
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
