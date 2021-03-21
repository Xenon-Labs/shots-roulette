import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shots_roulette/sharedWidgets/defaultDialog.dart';

List<String> drinkWords = [
  "DRINK!",
  "SHOT!",
  "DRINK!",
  "SHOT!",
  "CHUG IT!",
  "DON'T BE A PUSSY",
  "TIME TO GO HOME?",
  "NO EXCUSES",
  "TASTES LIKE WATER"
];

class GameSession extends StatefulWidget {
  GameSession({Key key, @required this.horizontalShotsNum}) : super(key: key);

  final int horizontalShotsNum;

  @override
  _GameSessionState createState() => _GameSessionState();
}

class _GameSessionState extends State<GameSession>
    with TickerProviderStateMixin {
  var arraySpots;
  int numOfSpotsLeft;
  double height;
  double width;
  int randomCol;
  int randomRow;
  Color colorFull = Color(0xFFe0f2f1);
  Color colorEmpty = Colors.white;
  Random rnd = new Random();
  bool inProgress = false;

  void init() {
    numOfSpotsLeft = widget.horizontalShotsNum * 2 + 4;
    //true = empty
    //false = spinning
    //null = full
    arraySpots = List.generate(widget.horizontalShotsNum + 2, (i) => List(2),
        growable: false);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _handleOnPressed() async {
    inProgress = true;
    if (randomCol != null && randomRow != null) {
      arraySpots[randomRow][randomCol] = false;
    }
    await rotateColor(rnd.nextInt(5) + 2);
    randomShot();
    inProgress = false;
  }

  Future<void> rotateColor(int numberOfTimes) async {
    for (int times = 0; times < numberOfTimes; times++) {
      for (int j = 1; j >= 0; j--) {
        for (int i = j == 1 ? 0 : widget.horizontalShotsNum + 1;
            j == 1 ? i < widget.horizontalShotsNum + 2 : i >= 0;
            j == 1 ? i++ : i--) {
          if (arraySpots[i][j] == null) {
            setState(() {
              arraySpots[i][j] = false;
            });
            await Future.delayed(const Duration(milliseconds: 70), () {});

            setState(() {
              arraySpots[i][j] = null;
            });
          }
        }
      }
    }
  }

  void randomShot() {
    randomCol = rnd.nextInt(2);
    randomRow = rnd.nextInt(widget.horizontalShotsNum + 2);
    if (arraySpots[randomRow][randomCol] != null ||
        arraySpots[randomRow][randomCol] == false) {
      randomShot();
      return;
    }

    setState(() {
      arraySpots[randomRow][randomCol] = true;
    });
    numOfSpotsLeft--;
    if (numOfSpotsLeft == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return DefaultDialog(
                child: Text(
                  "Play Again? \n ... or go home",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                buttonText: "Lets go!",
                buttonAction: () {
                  setState(() {
                    init();
                  });
                  Navigator.of(context).pop();
                });
          });
    }
  }

  List<Row> getRows() {
    List<Row> listOfRows = [];
    listOfRows.add(topBottomRow(arraySpots[0][0], arraySpots[0][1]));
    for (int i = 0; i < widget.horizontalShotsNum; i++) {
      listOfRows.add(regularRow(arraySpots[i + 1][0], arraySpots[i + 1][1]));
    }
    listOfRows.add(topBottomRow(arraySpots[widget.horizontalShotsNum + 1][0],
        arraySpots[widget.horizontalShotsNum + 1][1]));
    return listOfRows;
  }

  Row regularRow(bool first, bool second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getFullShot(width, height, widget.horizontalShotsNum + 2, first),
        getFullShot(width, height, widget.horizontalShotsNum + 2, second)
      ],
    );
  }

  Row topBottomRow(bool first, bool second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getFullShot(width, height, widget.horizontalShotsNum + 2, first),
        getFullShot(width, height, widget.horizontalShotsNum + 2, second)
      ],
    );
  }

  AnimatedContainer getFullShot(
      double width, double height, int rows, bool value) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 70),
        width: width / 3,
        height: height / rows,
        child: value != null && value == true
            ? Center(
                child: Text(
                (drinkWords..shuffle()).first,
                textAlign: TextAlign.center,
              ))
            : Container(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value == null ? colorFull : colorEmpty));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Center(
            child: RaisedButton(
                child: Text("Spin"),
                onPressed: inProgress ? null : _handleOnPressed),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getRows(),
          ),
        ],
      )),
    );
  }
}
