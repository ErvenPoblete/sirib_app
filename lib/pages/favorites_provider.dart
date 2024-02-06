import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sirib_app/dictionary_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Dictionary> _favorites = [];

  List<Dictionary> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesJson = prefs.getStringList('favorites');

    if (favoritesJson != null) {
      _favorites.addAll(favoritesJson.map((json) {
        Map<String, dynamic> map = jsonDecode(json);
        return Dictionary.fromJson(map);
      }));
      notifyListeners();
    }
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritesJson =
        _favorites.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList('favorites', favoritesJson);
  }

  void addToFavorites(Dictionary dictionary) {
    _favorites.add(dictionary);
    _saveFavorites();
    notifyListeners();
  }

  void removeFromFavorites(Dictionary dictionary) {
    _favorites.remove(dictionary);
    _saveFavorites();
    notifyListeners();
  }
}
