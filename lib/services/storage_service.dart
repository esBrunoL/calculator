import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _displayKey = 'calculator_display';

  static Future<void> saveDisplayValue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    // Only save if it's not an error state and not the default 0
    if (value != 'ERROR' && value != 'OVERFLOW' && value != '0') {
      await prefs.setString(_displayKey, value);
    }
  }

  static Future<String> getDisplayValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_displayKey) ?? '0';
  }

  static Future<void> clearStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_displayKey);
  }
}