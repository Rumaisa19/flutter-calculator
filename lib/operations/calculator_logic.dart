import 'package:expressions/expressions.dart';

class CalculatorLogic {
  String input = '';
  String result = '';
  String buttonPressed = '';

  // Add value to the input string
  void addInput(String value) {
    input += value;
  }

  // Clear everything
  void clear() {
    input = '';
    result = '';
  }

  void backSpace() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
    }
  }

  // Perform calculation
  String calculate() {
    try {
      // Replace symbols
      String expression = input.replaceAll('x', '*').replaceAll('÷', '/');

      // Create evaluator (from expressions package)
      final evaluator = const ExpressionEvaluator();
      final exp = Expression.parse(expression);

      // Evaluate with an empty context
      final value = evaluator.eval(exp, {});

      result = value.toString();
      return result;
    } catch (e) {
      result = 'Error';
      return result;
    }
  }

  // Simple manual fallback evaluator (optional)
  double _evaluate(String expression) {
    if (expression.contains('+')) {
      final parts = expression.split('+');
      return double.parse(parts[0]) + double.parse(parts[1]);
    } else if (expression.contains('-')) {
      final parts = expression.split('-');
      return double.parse(parts[0]) - double.parse(parts[1]);
    } else if (expression.contains('*')) {
      final parts = expression.split('*');
      return double.parse(parts[0]) * double.parse(parts[1]);
    } else if (expression.contains('/')) {
      final parts = expression.split('/');
      return double.parse(parts[0]) / double.parse(parts[1]);
    }

    return 0; // fallback
  }
}
