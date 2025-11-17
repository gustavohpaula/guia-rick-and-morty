import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'locations_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia Rick and Morty')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Explore personagens e locais do universo Rick and Morty.',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CharactersScreen())),
                child: const Text('Personagens')),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LocationsScreen())),
                child: const Text('Locais')),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen())),
                child: const Text('Favoritos')),
          ],
        ),
      ),
    );
  }
}
