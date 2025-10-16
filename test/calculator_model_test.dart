import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/models/calculator_model.dart';

void main() {
  group('Calculator Model Tests', () {
    late CalculatorModel calculator;

    setUp(() {
      calculator = CalculatorModel();
    });

    test('should display 0 initially', () {
      expect(calculator.display, '0');
    });

    test('should input single digits correctly', () {
      calculator.inputDigit('5');
      expect(calculator.display, '5');
    });

    test('should input multiple digits correctly', () {
      calculator.inputDigit('1');
      calculator.inputDigit('2');
      calculator.inputDigit('3');
      expect(calculator.display, '123');
    });

    test('should perform addition correctly', () {
      calculator.inputDigit('5');
      calculator.inputOperation('+');
      calculator.inputDigit('3');
      calculator.calculate();
      expect(calculator.display, '8');
    });

    test('should perform subtraction correctly', () {
      calculator.inputDigit('1');
      calculator.inputDigit('0');
      calculator.inputOperation('-');
      calculator.inputDigit('3');
      calculator.calculate();
      expect(calculator.display, '7');
    });

    test('should perform multiplication correctly', () {
      calculator.inputDigit('6');
      calculator.inputOperation('*');
      calculator.inputDigit('7');
      calculator.calculate();
      expect(calculator.display, '42');
    });

    test('should perform division correctly', () {
      calculator.inputDigit('1');
      calculator.inputDigit('5');
      calculator.inputOperation('/');
      calculator.inputDigit('3');
      calculator.calculate();
      expect(calculator.display, '5');
    });

    test('should handle division by zero', () {
      calculator.inputDigit('5');
      calculator.inputOperation('/');
      calculator.inputDigit('0');
      calculator.calculate();
      expect(calculator.display, 'ERROR');
      expect(calculator.hasError, true);
    });

    test('should handle overflow for long numbers', () {
      calculator.inputDigit('1');
      calculator.inputDigit('2');
      calculator.inputDigit('3');
      calculator.inputDigit('4');
      calculator.inputDigit('5');
      calculator.inputDigit('6');
      calculator.inputDigit('7');
      calculator.inputDigit('8');
      calculator.inputDigit('9'); // This should trigger overflow
      expect(calculator.display, 'OVERFLOW');
      expect(calculator.hasError, true);
    });

    test('should clear display and state with clear()', () {
      calculator.inputDigit('5');
      calculator.inputOperation('+');
      calculator.inputDigit('3');
      calculator.clear();
      expect(calculator.display, '0');
      expect(calculator.hasError, false);
    });

    test('should clear entry with clearEntry()', () {
      calculator.inputDigit('1');
      calculator.inputDigit('2');
      calculator.inputDigit('3');
      calculator.clearEntry();
      expect(calculator.display, '0');
    });

    test('should handle decimal input correctly', () {
      calculator.inputDigit('5');
      calculator.inputDecimal();
      calculator.inputDigit('2');
      expect(calculator.display, '5.2');
    });

    test('should not allow multiple decimal points', () {
      calculator.inputDigit('5');
      calculator.inputDecimal();
      calculator.inputDigit('2');
      calculator.inputDecimal(); // Should be ignored
      calculator.inputDigit('3');
      expect(calculator.display, '5.23');
    });

    test('should handle chained operations', () {
      calculator.inputDigit('5');
      calculator.inputOperation('+');
      calculator.inputDigit('3');
      calculator.inputOperation('*'); // Should calculate 5+3=8, then prepare for *
      calculator.inputDigit('2');
      calculator.calculate();
      expect(calculator.display, '16'); // 8 * 2 = 16
    });
  });
}