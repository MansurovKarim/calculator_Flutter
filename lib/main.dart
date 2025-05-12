import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _shouldClear = false;

  void _onPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _display = '0';
        _firstOperand = null;
        _operator = null;
      } else if (value == '+/-') {
        if (_display.startsWith('-')) {
          _display = _display.substring(1);
        } else {
          _display = '-$_display';
        }
      } else if (value == '%') {
        _display = (double.parse(_display) / 100).toString();
      } else if ('÷×−+'.contains(value)) {
        _firstOperand = double.parse(_display);
        _operator = value;
        _shouldClear = true;
      } else if (value == '=') {
        double secondOperand = double.parse(_display);
        double result = 0;
        switch (_operator) {
          case '+':
            result = _firstOperand! + secondOperand;
            break;
          case '−':
            result = _firstOperand! - secondOperand;
            break;
          case '×':
            result = _firstOperand! * secondOperand;
            break;
          case '÷':
            result = _firstOperand! / secondOperand;
            break;
        }
        _display = result.toString().replaceAll(RegExp(r"\.0+$"), "");
        _operator = null;
      } else {
        if (_shouldClear) {
          _display = value == '.' ? '0.' : value;
          _shouldClear = false;
        } else {
          if (_display == '0' && value != '.') {
            _display = value;
          } else if (value == '.' && _display.contains('.')) {
            return;
          } else {
            _display += value;
          }
        }
      }
    });
  }

  Widget neumorphicButton(String text, {Color textColor = Colors.black87, Color buttonColor = const Color(0xFFE0E0E0), double width = 77}) {
    return GestureDetector(
      onTap: () => _onPressed(text),
      child: Container(
        width: width,
        height: 77,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 28,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2C),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    neumorphicButton('AC', textColor: Colors.black, buttonColor: Colors.grey),
                    neumorphicButton('+/-', textColor: Colors.black, buttonColor: Colors.grey),
                    neumorphicButton('%', textColor: Colors.black, buttonColor: Colors.grey),
                    neumorphicButton('÷', textColor: Colors.white, buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    neumorphicButton('7', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('8', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('9', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('×', textColor: Colors.white, buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    neumorphicButton('4', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('5', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('6', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('-', textColor: Colors.white, buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    neumorphicButton('1', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('2', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('3', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('+', textColor: Colors.white, buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    neumorphicButton('0', textColor: Colors.white, buttonColor: Color(0xFF505050), width: 175),
                    neumorphicButton('.', textColor: Colors.white, buttonColor: Color(0xFF505050)),
                    neumorphicButton('=', textColor: Colors.white, buttonColor: Colors.orange),

                  ],
                ),
                const SizedBox(height: 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}