import 'package:flutter/material.dart';
import 'package:calculator_app/models/calculator_model.dart';
import 'package:calculator_app/services/storage_service.dart';
import 'package:calculator_app/widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorModel _calculator = CalculatorModel();

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  Future<void> _loadSavedValue() async {
    final savedValue = await StorageService.getDisplayValue();
    setState(() {
      _calculator.setDisplayValue(savedValue);
    });
  }

  Future<void> _saveValue() async {
    await StorageService.saveDisplayValue(_calculator.display);
  }

  void _onNumberPressed(String number) {
    setState(() {
      _calculator.inputDigit(number);
    });
    _saveValue();
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _calculator.inputOperation(operation);
    });
    _saveValue();
  }

  void _onEqualsPressed() {
    setState(() {
      _calculator.calculate();
    });
    _saveValue();
  }

  void _onClearPressed() {
    setState(() {
      _calculator.clear();
    });
    _saveValue();
  }

  void _onClearEntryPressed() {
    setState(() {
      _calculator.clearEntry();
    });
    _saveValue();
  }

  void _onDecimalPressed() {
    setState(() {
      _calculator.inputDecimal();
    });
    _saveValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Bruno's pocket Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // History line (smaller, on top)
                    if (_calculator.history.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _calculator.history,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[400],
                            fontFamily: 'monospace',
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // Main display (larger, bottom)
                    Text(
                      _calculator.display,
                      style: TextStyle(
                        fontSize: _calculator.display.length > 6 ? 36 : 48,
                        fontWeight: FontWeight.w300,
                        color: _calculator.hasError ? Colors.red[300] : Colors.white,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Button Area
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Row 1: CE, C, /, *
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            text: 'CE',
                            onPressed: _onClearEntryPressed,
                            backgroundColor: Colors.orange[300],
                            textColor: Colors.white,
                            fontSize: 20,
                          ),
                          CalculatorButton(
                            text: 'C',
                            onPressed: _onClearPressed,
                            backgroundColor: Colors.red[400],
                            textColor: Colors.white,
                            fontSize: 20,
                          ),
                          CalculatorButton(
                            text: '/',
                            onPressed: () => _onOperationPressed('/'),
                            backgroundColor: Colors.blueGrey[600],
                            textColor: Colors.white,
                          ),
                          CalculatorButton(
                            text: '*',
                            onPressed: () => _onOperationPressed('*'),
                            backgroundColor: Colors.blueGrey[600],
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 2: 7, 8, 9, -
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            text: '7',
                            onPressed: () => _onNumberPressed('7'),
                          ),
                          CalculatorButton(
                            text: '8',
                            onPressed: () => _onNumberPressed('8'),
                          ),
                          CalculatorButton(
                            text: '9',
                            onPressed: () => _onNumberPressed('9'),
                          ),
                          CalculatorButton(
                            text: '-',
                            onPressed: () => _onOperationPressed('-'),
                            backgroundColor: Colors.blueGrey[600],
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 3: 4, 5, 6, +
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            text: '4',
                            onPressed: () => _onNumberPressed('4'),
                          ),
                          CalculatorButton(
                            text: '5',
                            onPressed: () => _onNumberPressed('5'),
                          ),
                          CalculatorButton(
                            text: '6',
                            onPressed: () => _onNumberPressed('6'),
                          ),
                          CalculatorButton(
                            text: '+',
                            onPressed: () => _onOperationPressed('+'),
                            backgroundColor: Colors.blueGrey[600],
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 4: 1, 2, 3, =
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            text: '1',
                            onPressed: () => _onNumberPressed('1'),
                          ),
                          CalculatorButton(
                            text: '2',
                            onPressed: () => _onNumberPressed('2'),
                          ),
                          CalculatorButton(
                            text: '3',
                            onPressed: () => _onNumberPressed('3'),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _onEqualsPressed,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[600],
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 2,
                                        shadowColor: Colors.black26,
                                      ),
                                      child: const Text(
                                        '=',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row 5: 0 (wide), .
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            text: '0',
                            onPressed: () => _onNumberPressed('0'),
                            isWide: true,
                          ),
                          CalculatorButton(
                            text: '.',
                            onPressed: _onDecimalPressed,
                            backgroundColor: Colors.grey[400],
                          ),
                          // Empty space to maintain layout
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}