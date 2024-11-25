import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Column(
          children: [
            Expanded(
                child: Container(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))),
            Expanded(
                flex: 2,
                child: Container(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: ((context, index) {
                          //clear button
                          if (index == 0) {
                            return MyButtons(
                                color: Colors.green,
                                textColor: Colors.white,
                                buttonText: buttons[index],
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = '';
                                    userAnswer = '';
                                  });
                                });
                          }

                          // delete button
                          else if (index == 1) {
                            return MyButtons(
                                color: Colors.red,
                                textColor: Colors.white,
                                buttonText: buttons[index],
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                  });
                                });
                          }

                          //equal button

                          else if (index == buttons.length - 1) {
                            return MyButtons(
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                buttonText: buttons[index],
                                buttonTapped: () {
                                  setState(() {
                                    equalPressed();
                                  });
                                });
                          } else {
                            return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion += buttons[index];
                                  });
                                },
                                color: isOperator(buttons[index])
                                    ? Colors.deepPurple
                                    : Colors.deepPurple[50],
                                textColor: isOperator(buttons[index])
                                    ? Colors.white
                                    : Colors.deepPurple,
                                buttonText: buttons[index]);
                          }
                        })))),
          ],
        ));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
