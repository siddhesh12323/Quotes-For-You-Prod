import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void addToFavorites(QuoteModel quote) async {
    if (!_favorites.contains(quote)) {
      // await FirebaseFirestore.instance.collection('saved_quotes').add(quote
      //     .toJson());
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('saved_quotes')
          .doc("${quote.q} + ${quote.a}") // Specify the custom ID
          .set(quote.toJson());
      _favorites.add(quote);
      saveFavorites();
    }
    notifyListeners();
  }

  void removeFromFavorites(QuoteModel quote) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('saved_quotes')
        .doc("${quote.q} + ${quote.a}")
        .delete();
    _favorites.remove(quote);
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(QuoteModel quote) {
    return _favorites.contains(quote);
  }
}
