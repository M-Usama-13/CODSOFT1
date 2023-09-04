import 'package:calculator/my_btn.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List myBtns = [
    'C',
    'Del',
    '%',
    '\u00F7',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    '+/-',
    '=',
  ];

  bool isOperator(str) {
    if (str == '=' ||
        str == '-' ||
        str == 'x' ||
        str == '+' ||
        str == '\u00F7' ||
        str == '%' ||
        str == '+/-') {
      return true;
    } else {
      return false;
    }
  }

  String equation = '';
  String solution = '';

  void equalBtn(){
    String  finalAnswer = equation;
    finalAnswer = finalAnswer.replaceAll('x', '*');
    Parser p  = Parser();
    Expression exp  = p.parse(finalAnswer);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    solution = eval.toString();
  }
  void signChange(){
    setState((){
      if(solution[0]!='-'){
        solution = '-$solution';
      }
      else{
        solution = solution.substring(1);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Expanded(
              flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 23),
                        child: Text(
                          equation,
                          style: const TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 23),
                        alignment: Alignment.bottomRight,
                        child: Text(solution,
                          style: const TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: myBtns.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyBtn(
                        btnTapped: () {
                          setState((){
                            equation = '';
                          });
                        },
                        text: myBtns[index],
                        textColor: Colors.black,
                        color: Colors.lightGreen);
                  } else if (index == 1) {
                    return MyBtn(
                        btnTapped: () {
                          setState((){
                            equation = equation.substring(0,equation.length-1);
                          });
                        },
                        text: myBtns[index],
                        textColor: Colors.black,
                        color: Colors.red);
                  }else if (index == myBtns.length-1) {
                    return MyBtn(
                        btnTapped: () {
                          setState((){
                            equalBtn();
                          });
                        },
                        text: myBtns[index],
                        textColor: Colors.black,
                        color: Colors.blue
                    );
                  }
                  else if(myBtns[index] == '+/-'){
                    return MyBtn(
                        btnTapped: () {
                          setState((){
                            signChange();
                          });
                        },
                        text: myBtns[index],
                        textColor: Colors.black,
                        color: Colors.blue
                    );
                  }
                  else {
                    return MyBtn(
                        btnTapped: () {
                          setState((){
                            equation += myBtns[index];
                          });
                        },
                        text: myBtns[index],
                        textColor: isOperator(myBtns[index])
                            ? Colors.black
                            : Colors.blue,
                        color: isOperator(myBtns[index])
                            ? Colors.blue
                            : Colors.black12);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
