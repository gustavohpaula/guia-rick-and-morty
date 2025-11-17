import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _key = 'favorites_ids';
  List<int> favoriteIds = [];

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      favoriteIds = list.map((e) => e as int).toList();
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(favoriteIds));
  }

  bool isFavorite(int id) => favoriteIds.contains(id);
}
