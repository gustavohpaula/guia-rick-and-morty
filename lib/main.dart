import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/character_provider.dart';
import 'providers/favorites_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favoritesProvider = FavoritesProvider();
  await favoritesProvider.loadFavorites();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ChangeNotifierProvider(create: (_) => favoritesProvider),
    ],
    child: const MyApp(),
  ));
}
