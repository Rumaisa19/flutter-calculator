import 'package:flutter/material.dart';
import '../operations/calculator_logic.dart';
import '../themes/app_colors.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorLogic calculator =
      CalculatorLogic(); // Calculator logic instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0, // Flat app bar for modern look
      ),

      body: Column(
        children: [
          // ==============================
          // Display Area (Input & Result)
          // ==============================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Input display with spaces around operators
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    calculator.input
                        .replaceAll('+', ' + ')
                        .replaceAll('-', ' - ')
                        .replaceAll('x', ' x ')
                        .replaceAll('/', ' / ')
                        .replaceAll('%', ' % '),
                    style: const TextStyle(fontSize: 28, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 15), // Slightly bigger space for clarity
                // Result display
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: Text(
                      calculator.result,
                      key: ValueKey(calculator.result),
                      style: const TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white),

          // ==============================
          // Calculator Buttons
          // ==============================

          // Row 1: AC, Backspace, Decimal, Division
          Row(
            children: [
              calcButton(
                'AC',
                AppColors.actionColor,
              ), // Clear all input & result
              calcButton('⌫', AppColors.actionColor), // Delete last character
              calcButton('.', AppColors.accentColor), // Decimal point
              calcButton('/', AppColors.operatorColor), // Division operator
            ],
          ),

          Row(
            children: [
              calcButton('7', AppColors.buttonColor),
              calcButton('8', AppColors.buttonColor),
              calcButton('9', AppColors.buttonColor),
              calcButton('x', AppColors.operatorColor), // Multiplication
            ],
          ),

          Row(
            children: [
              calcButton('4', AppColors.buttonColor),
              calcButton('5', AppColors.buttonColor),
              calcButton('6', AppColors.buttonColor),
              calcButton('-', AppColors.operatorColor), // Subtraction
            ],
          ),

          Row(
            children: [
              calcButton('1', AppColors.buttonColor),
              calcButton('2', AppColors.buttonColor),
              calcButton('3', AppColors.buttonColor),
              calcButton('+', AppColors.operatorColor), // Addition
            ],
          ),

          Row(
            children: [
              calcButton('0', AppColors.buttonColor),
              calcButton('00', AppColors.buttonColor),
              calcButton('%', AppColors.operatorColor), // Modulo
              calcButton('=', AppColors.accentColor), // Calculate result
            ],
          ),
        ],
      ),
    );
  }

  // ==============================
  // Custom Button Builder
  Widget calcButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTapDown: (_) => setState(() => calculator.buttonPressed = text),
          onTapUp: (_) => setState(() => calculator.buttonPressed = ''),
          onTapCancel: () => setState(() => calculator.buttonPressed = ''),
          onTap: () {
            setState(() {
              if (text == 'AC') {
                calculator.clear();
              } else if (text == '=') {
                calculator.calculate();
              } else if (text == '⌫') {
                calculator.backSpace();
              } else {
                calculator.addInput(text);
              }
            });
          },
          child: Transform.scale(
            scale: calculator.buttonPressed == text ? 0.95 : 1.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 24),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              onPressed: null,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ), // Disabled because we're using GestureDetector
            ),
          ),
        ),
      ),
    );
  }
}
