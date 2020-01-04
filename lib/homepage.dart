import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'converter/converter.dart';

var operator = ["+", "-", ".", "%", "÷", "×", " "];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String to perform calculation Operations
  bool operatorLock = true, afterEqual = false, dotLock = false;
  String expression = "", answer = "";
  double answerSize = 32.0, deviceHeight, deviceWidth;

  void Clicked({String value}) {
    setState(() {
      if (afterEqual) Reset();
      if (value == "⩤") {
        if (expression.length == 1 || expression.length == 0) {
          Reset();
          return;
        }
        int r = 1;
        // r is fot number to delete from string according to condition of %*;
        if (expression[expression.length - 1] == " ") {
          if (expression[expression.length - 2] == "×" &&
              expression[expression.length - 3] == "%")
            r = 4;
          else
            r = 3;
        }
        expression = expression.replaceRange(
            expression.length - r, expression.length, "");

        if (operator.contains(expression[expression.length - 1])) {
          return;
        }
      } else {
        if (expression == "0") {
          if (value != "0") {
            expression = value;
          }
        } else if (value == ".") {
          if (dotLock) return;
          expression += value;
          dotLock = true;
        } else {
          expression += value;
        }
      }

      Parser p = new Parser();
      String evaluation = expression.replaceAll("%×", "*0.01*");

      evaluation = evaluation.replaceAll("×", "*");

      Expression exp = p.parse(evaluation.replaceAll("÷", "/"));
      // print('Simplified expression: ${exp.simplify()}\n');
      answer = exp.evaluate(EvaluationType.REAL, null).toString();

      if (answer.length > MediaQuery.of(context).size.width / 24.5)
        answerSize = MediaQuery.of(context).size.width / 19;
      else
        answerSize = 32.0;

      operatorLock = false;
    });
  }

  void Reset() {
    // isLocked = false;
    operatorLock = true;
    expression = "";
    answer = "";
    afterEqual = false;
    dotLock = false;
  }

  // Function to perform Operation on Expression
  void PowerClicked(String value) {
    setState(() {
      dotLock = false;
      //If Max Power clicked
      if (value == "C" || value == "=") {
        if (value == "C") {
          Reset();
        } else if (value == "=") {
          afterEqual = true;
          expression = answer;
        }
      } else if (!operatorLock) {
        if (value == "%") value = "%×";
        if (value == "mod") value = "%";
        afterEqual = false;

        int lastIndex = expression.length - 1;

        if (expression[lastIndex] == " ") {
          if (expression[lastIndex - 1] != value) {
            int r = 2;
            // int r for number of char we have to change (r-1)...
            if (operator.contains(expression[lastIndex - 1]) &&
                expression[lastIndex - 2] == "%") {
              print('Firing Strike');
              r = 3;
            }
            expression = expression.replaceRange(
                expression.length - r, expression.length - 1, value);
          }

          // expression = expression.replaceAll(expression[lastIndex-1], value);
        } else {
          expression += " " + value + " ";
        }
      }
    });
  }

  Widget layoutButton({String text = "B", int index = 0, onPressed}) {
    if (index == 0 || index == 3) {
      return Expanded(
        child: Material(
                  child: InkWell(
            // customBorder: StadiumBorder(),
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            splashFactory: InkRipple.splashFactory,
            child: Center(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 0.033197832 * deviceHeight,
                      fontWeight: FontWeight.w400,
                      color: index == 3 ? Colors.blue : Colors.black)),
            ),
            onTap: () => Clicked(value: text),
          ),
        ),
      );
    }
    return Expanded(
      child: Material(
        color: index == 2
            ? Colors.red[100]
            : index == 4 ? Colors.blue[200] : Colors.blue[100],
        child: InkWell(
          splashColor: Colors.blueAccent[100],
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          splashFactory: InkRipple.splashFactory,
          child: Center(
            child: Text(text,
                style: TextStyle(
                    fontSize: 0.033197832 * deviceHeight,
                    fontWeight: FontWeight.bold,
                    color: index == 2 ? Colors.black : Colors.blue)),
          ),
          onTap: () {
            PowerClicked(text);
          },
        ),
      ),
    );
  }

  Widget BottomPart() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              layoutButton(text: "C", index: 2),
              layoutButton(text: "mod", index: 1),
              layoutButton(text: "%", index: 1),
              layoutButton(text: "÷", index: 1),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              layoutButton(text: "7"),
              layoutButton(text: "8"),
              layoutButton(text: "9"),
              layoutButton(text: "×", index: 1),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              layoutButton(text: "4"),
              layoutButton(text: "5"),
              layoutButton(text: "6"),
              layoutButton(text: "-", index: 1),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              layoutButton(text: "1"),
              layoutButton(text: "2"),
              layoutButton(text: "3"),
              layoutButton(text: "+", index: 1),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              layoutButton(text: "0"),
              layoutButton(text: "."),
              layoutButton(text: "⩤", index: 3),
              layoutButton(text: "=", index: 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget TopPart(BuildContext context) {
    return Container(
      color: Colors.blueAccent[200],
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30.0,
            bottom: 40.0,
            right: 30.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  expression,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: deviceWidth * 0.072916667),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "=",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * 0.077777778),
                      ),
                      Text(
                        answer,
                        style: TextStyle(
                            color: Colors.white, fontSize: answerSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        elevation: 0.0,
      ),
      drawerEdgeDragWidth: deviceWidth/2.3,
      drawer: Converter(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TopPart(context),
          ),
          Expanded(
            // flex: 2,
            child: BottomPart(),
          )
        ],
      ),
    );
  }
}
