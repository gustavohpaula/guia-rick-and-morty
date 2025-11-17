import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/location.dart';
import '../services/api_service.dart';

class CharacterProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Character> characters = [];
  int currentPage = 1;
  bool hasNext = true;
  bool loading = false;
  String? error;

  Future<void> loadInitial() async {
    characters = [];
    currentPage = 1;
    hasNext = true;
    await loadMore();
  }

  Future<List<dynamic>> fetchMultipleCharactersByUrls(List<String> urls) {
    return _api.fetchMultipleCharactersByUrls(urls);
  }

  Future<void> loadMore() async {
    if (!hasNext || loading) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final res = await _api.fetchCharacters(currentPage);
      final info = res['info'];
      final results = res['results'] as List<dynamic>;
      characters.addAll(results.map((e) => Character.fromJson(e)).toList());
      currentPage++;
      hasNext = info['next'] != null;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<Character> getById(int id) async {
    return await _api.fetchCharacterById(id);
  }

  List<RMLocation> locations = [];
  int locationPage = 1;
  bool locationHasNext = true;
  bool locationsLoading = false;

  Future<void> loadLocationsInitial() async {
    locations = [];
    locationPage = 1;
    locationHasNext = true;
    await loadMoreLocations();
  }

  Future<void> loadMoreLocations() async {
    if (!locationHasNext || locationsLoading) return;
    locationsLoading = true;
    notifyListeners();
    try {
      final res = await _api.fetchLocations(locationPage);
      final info = res['info'];
      final results = res['results'] as List<dynamic>;
      locations.addAll(results.map((e) => RMLocation.fromJson(e)).toList());
      locationPage++;
      locationHasNext = info['next'] != null;
    } catch (e) {
    } finally {
      locationsLoading = false;
      notifyListeners();
    }
  }
}
