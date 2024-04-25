import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    super.key,
  });

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  void _handleButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _input = _calculateResult();
      } else if (buttonText == 'AC') {
        _input = '';
      } else if (buttonText == '√') {
        _input = _calculateSquareRoot();
      } else if (buttonText == 'π') {
        _input += '3.14159';
      } else if (buttonText == 'x!') {
        _input += '!';
      } else if (buttonText == 'x^y') {
        _input += '^';
      } else if (buttonText == 'rad') {
        _input += 'radians(';
      } else if (buttonText == 'deg') {
        _input += 'degrees(';
      } else if (buttonText == '00') {
        _input += '00';
      } else {
        _input += buttonText;
      }
    });
  }

  String _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      }
      return result.toStringAsFixed(2); // Format result to two decimal places
    } catch (e) {
      return 'Error';
    }
  }

  String _calculateSquareRoot() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('sqrt($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      }
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 108, 104, 104),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 209, 203, 203),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  _buildButtonRow(['AC', '√', '00', '=']),
                  _buildButtonRow(['7', '8', '9', 'x^y']),
                  _buildButtonRow(['4', '5', '6', 'x!']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['.', '0', 'rad', 'deg']),
                  // _buildButtonRow(['sin', 'cos', 'tan', '/']),
                  // _buildButtonRow(['ln', 'log', '%', '*']),
                  _buildButtonRow(['π', '(', ')', '-']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonLabels) {
    return Expanded(
      child: Row(
        children: buttonLabels
            .map((label) => Expanded(child: _buildButton(label)))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => _handleButtonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(133, 206, 101, 8)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    ),
  );
}
