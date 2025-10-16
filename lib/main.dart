import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String operand1 = '';
  String operand2 = '';
  String operator = '';
  bool shouldResetDisplay = false;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        operand1 = '';
        operand2 = '';
        operator = '';
        shouldResetDisplay = false;
      } else if (value == '+' || value == '-' || value == '*' || value == '/' || value == '%') {
        operand1 = display;
        operator = value;
        shouldResetDisplay = true;
      } else if (value == '=') {
        if (operand1.isNotEmpty && operator.isNotEmpty) {
          operand2 = display;
          double num1 = double.parse(operand1);
          double num2 = double.parse(operand2);
          double result = 0;

          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case '*':
              result = num1 * num2;
              break;
            case '/':
              result = num2 != 0 ? num1 / num2 : 0;
              break;
            case '%':
              result = num1 % num2;
              break;
          }

          display = result.toString();
          if (display.endsWith('.0')) {
            display = display.substring(0, display.length - 2);
          }
          operand1 = '';
          operand2 = '';
          operator = '';
          shouldResetDisplay = true;
        }
      } else if (value == '.') {
        if (!display.contains('.')) {
          display += '.';
        }
      } else {
        if (shouldResetDisplay || display == '0') {
          display = value;
          shouldResetDisplay = false;
        } else {
          display += value;
        }
      }
    });
  }

  Widget buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(24),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Simple Calculator'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('/', color: Colors.orange[700]),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('*', color: Colors.orange[700]),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('-', color: Colors.orange[700]),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      buildButton('0'),
                      buildButton('.'),
                      buildButton('%', color: Colors.orange[700]),
                      buildButton('+', color: Colors.orange[700]),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      buildButton('C', color: Colors.red[700]),
                      buildButton('=', color: Colors.green[700]),
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
}