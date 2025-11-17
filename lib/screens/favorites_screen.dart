import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/character_provider.dart';
import '../widgets/loading_widget.dart';
import 'character_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesProvider>(context);
    final charProv = Provider.of<CharacterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: fav.favoriteIds.isEmpty
          ? const Center(child: Text('Nenhum favorito ainda'))
          : FutureBuilder(
              future: charProv.fetchMultipleCharactersByUrls(
                fav.favoriteIds
                    .map(
                      (id) => 'https://rickandmortyapi.com/api/character/$id',
                    )
                    .toList(),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return const LoadingWidget();
                if (snapshot.hasError)
                  return Center(child: Text('Erro: \${snapshot.error}'));
                final list = snapshot.data as List<dynamic>;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final c = list[i];
                    return ListTile(
                      leading:
                          CircleAvatar(backgroundImage: NetworkImage(c.image)),
                      title: Text(c.name),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CharacterDetailScreen(id: c.id))),
                    );
                  },
                );
              },
            ),
    );
  }
}
