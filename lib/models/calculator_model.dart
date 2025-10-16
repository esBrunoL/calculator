class CalculatorModel {
  String _display = '0';
  String _previousOperand = '';
  String _operation = '';
  String _history = '';
  bool _waitingForNewOperand = false;
  bool _hasError = false;

  String get display => _display;
  String get history => _history;
  bool get hasError => _hasError;

  void inputDigit(String digit) {
    if (_hasError) {
      clear();
    }

    if (_waitingForNewOperand) {
      _display = digit;
      _waitingForNewOperand = false;
    } else {
      if (_display.length >= 8) {
        _setError('OVERFLOW');
        return;
      }
      _display = _display == '0' ? digit : _display + digit;
    }
  }

  void inputDecimal() {
    if (_hasError) {
      clear();
    }

    if (_waitingForNewOperand) {
      _display = '0.';
      _waitingForNewOperand = false;
    } else if (!_display.contains('.')) {
      if (_display.length >= 7) {
        _setError('OVERFLOW');
        return;
      }
      _display += '.';
    }
  }

  void inputOperation(String nextOperation) {
    if (_hasError) {
      return;
    }

    double operand = double.tryParse(_display) ?? 0;

    if (_previousOperand.isEmpty) {
      _previousOperand = operand.toString();
      // Start building history: "54 +"
      _history = '${_formatDisplayNumber(operand)} $nextOperation ';
    } else if (_operation.isNotEmpty) {
      double previousValue = double.tryParse(_previousOperand) ?? 0;
      double result = _calculate(previousValue, operand, _operation);
      
      if (_hasError) return;
      
      _display = _formatNumber(result);
      _previousOperand = result.toString();
      // Update history with result: "54 + 12 = 66, then 66 +"
      _history = '${_formatDisplayNumber(result)} $nextOperation ';
    }

    _waitingForNewOperand = true;
    _operation = nextOperation;
  }

  void calculate() {
    if (_hasError || _operation.isEmpty) {
      return;
    }

    double operand = double.tryParse(_display) ?? 0;
    double previousValue = double.tryParse(_previousOperand) ?? 0;
    
    // Complete history: "54 + 12 = "
    _history = '$_history${_formatDisplayNumber(operand)} = ';
    
    double result = _calculate(previousValue, operand, _operation);
    
    if (_hasError) return;
    
    _display = _formatNumber(result);
    _previousOperand = '';
    _operation = '';
    _waitingForNewOperand = true;
  }

  double _calculate(double firstOperand, double secondOperand, String operation) {
    switch (operation) {
      case '+':
        return firstOperand + secondOperand;
      case '-':
        return firstOperand - secondOperand;
      case '*':
        return firstOperand * secondOperand;
      case '/':
        if (secondOperand == 0) {
          _setError('ERROR');
          return 0;
        }
        return firstOperand / secondOperand;
      default:
        return secondOperand;
    }
  }

  String _formatNumber(double number) {
    if (number.isInfinite || number.isNaN) {
      _setError('ERROR');
      return 'ERROR';
    }

    // Check for overflow (8 digits max)
    String result = number.toString();
    if (number == number.truncateToDouble()) {
      result = number.toInt().toString();
    }

    if (result.length > 8) {
      // Try scientific notation for very large numbers
      if (number.abs() >= 100000000) {
        _setError('OVERFLOW');
        return 'OVERFLOW';
      }
      // For smaller numbers with many decimal places, round them
      result = number.toStringAsFixed(8 - result.split('.')[0].length - 1);
      if (result.length > 8) {
        _setError('OVERFLOW');
        return 'OVERFLOW';
      }
    }

    return result;
  }

  void _setError(String error) {
    _hasError = true;
    _display = error;
    _previousOperand = '';
    _operation = '';
    _waitingForNewOperand = true;
  }

  String _formatDisplayNumber(double number) {
    // Format number for display in history (simpler than main display)
    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  void clear() {
    _display = '0';
    _previousOperand = '';
    _operation = '';
    _history = '';
    _waitingForNewOperand = false;
    _hasError = false;
  }

  void clearEntry() {
    if (_hasError) {
      clear();
    } else {
      _display = '0';
      _waitingForNewOperand = false;
    }
  }

  void setDisplayValue(String value) {
    _display = value;
  }
}