import 'dart:math';

import 'package:flutter/material.dart';

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
  AnimationController _animationController;
  bool isPlaying = false;
  var arraySpots;
  int numOfSpotsLeft;
  double height;
  double width;
  int randomCol;
  int randomRow;

  @override
  void initState() {
    super.initState();
    //TODO: show to do dialog
    numOfSpotsLeft = widget.horizontalShotsNum * 2 + 2;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    arraySpots = List.generate(widget.horizontalShotsNum + 2, (i) => List(2),
        growable: false);
  }

  void _handleOnPressed() {
    if (randomCol != null && randomRow != null) {
      arraySpots[randomRow][randomCol] = false;
    }
    randomShot();

    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  void randomShot() {
    Random rnd = new Random();

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
      // TODO: play
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
        first == null
            ? getFullShot()
            : first
                ? drinkShot()
                : getEmptyShot(),
        second == null
            ? getFullShot()
            : second
                ? drinkShot()
                : getEmptyShot()
      ],
    );
  }

  Row topBottomRow(bool first, bool second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        first == null
            ? getFullShot()
            : first
                ? drinkShot()
                : getEmptyShot(),
        second == null
            ? getFullShot()
            : second
                ? drinkShot()
                : getEmptyShot()
      ],
    );
  }

  Container getEmptyShot() {
    return Container(
        width: width / 3,
        height: height / (widget.horizontalShotsNum + 2),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFe0f2f1)),
            shape: BoxShape.circle,
            color: Colors.white));
  }

  Container drinkShot() {
    return Container(
        width: width / 3,
        height: height / (widget.horizontalShotsNum + 2),
        child: Center(
            child: Text(
          (drinkWords..shuffle()).first,
          textAlign: TextAlign.center,
        )),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFe0f2f1)),
            shape: BoxShape.circle,
            color: Colors.white));
  }

  Container getFullShot() {
    return Container(
        width: width / 3,
        height: height / (widget.horizontalShotsNum + 2),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xFFe0f2f1)));
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
              onPressed: () => _handleOnPressed(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getRows(),
            // children: <Widget>[
            //   AnimatedIcon(
            //       icon: AnimatedIcons.arrow_menu, progress: _animationController),

            // ],
          ),
        ],
      )),
    );
  }
}
