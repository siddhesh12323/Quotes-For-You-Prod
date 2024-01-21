import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';

class FavoritesManager extends ChangeNotifier {
  List<QuoteModel> _favorites = [];

  List<QuoteModel> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    _favorites = favoritesJson
        .map((json) => QuoteModel.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson =
        _favorites.map((quote) => jsonEncode(quote.toJson())).toList();
    prefs.setStringList('favorites', favoritesJson);
  }

  void addToFavorites(QuoteModel quote) {
    if (!_favorites.contains(quote)) {
      _favorites.add(quote);
      saveFavorites();
    }
    notifyListeners();
  }

  void removeFromFavorites(QuoteModel quote) {
    _favorites.remove(quote);
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(QuoteModel quote) {
    return _favorites.contains(quote);
  }
}
