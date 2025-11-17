import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/location.dart';

class ApiService {
  static const base = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> fetchCharacters(int page) async {
    final uri = Uri.parse('$base/character?page=$page');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao carregar personagens: ${res.statusCode}');
    }
  }

  Future<Character> fetchCharacterById(int id) async {
    final uri = Uri.parse('$base/character/$id');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return Character.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Falha ao carregar personagem');
    }
  }

  Future<Map<String, dynamic>> fetchLocations(int page) async {
    final uri = Uri.parse('$base/location?page=$page');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao carregar locais: ${res.statusCode}');
    }
  }

  Future<RMLocation> fetchLocationById(int id) async {
    final uri = Uri.parse('$base/location/$id');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return RMLocation.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Falha ao carregar local');
    }
  }

  Future<List<Character>> fetchMultipleCharactersByUrls(
      List<String> urls) async {
    if (urls.isEmpty) return [];
    final ids = urls.map((u) => u.split('/').last).join(',');
    final uri = Uri.parse('$base/character/$ids');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      if (body is List) {
        return body.map((e) => Character.fromJson(e)).toList();
      } else {
        return [Character.fromJson(body)];
      }
    } else {
      throw Exception('Falha ao carregar residentes');
    }
  }
}
