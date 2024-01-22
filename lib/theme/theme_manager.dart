import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  Color _chosenColor = Colors.blue;
  String _chosenFont = 'ProductSans';
  final String _colorKey = 'selected_color';
  final String _fontKey = 'selected_font';

  Color get chosenColor => _chosenColor;
  String get chosenFont => _chosenFont;

  ThemeManager() {
    _loadColor();
    _loadFont();
  }

  Future<void> _loadFont() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedFont = prefs.getString(_fontKey);

    if (savedFont != null) {
      _setChosenFont(savedFont);
    } else {
      _setChosenFont('ProductSans'); // Default color
    }
  }

  void _setChosenFont(String font) {
    _chosenFont = font;
    notifyListeners();
  }

  Future<void> setChosenFont(String font) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontKey, font);
    _setChosenFont(font);
  }

  Future<void> _loadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedColor = prefs.getInt(_colorKey);

    if (savedColor != null) {
      _setChosenColor(Color(savedColor));
    } else {
      _setChosenColor(Colors.blue); // Default color
    }
  }

  void _setChosenColor(Color color) {
    _chosenColor = color;
    notifyListeners();
  }

  Future<void> setChosenColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, color.value);
    _setChosenColor(color);
  }
}
