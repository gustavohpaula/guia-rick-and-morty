import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';
import '../widgets/character_tile.dart';
import 'character_detail_screen.dart';
import '../widgets/loading_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final prov = Provider.of<CharacterProvider>(context, listen: false);
    prov.loadInitial();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 200) {
        prov.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personagens')),
      body: Consumer<CharacterProvider>(builder: (context, prov, _) {
        if (prov.characters.isEmpty && prov.loading)
          return const LoadingWidget();
        if (prov.error != null)
          return Center(child: Text('Erro: ${prov.error}'));
        return ListView.builder(
          controller: _scrollController,
          itemCount: prov.characters.length + (prov.hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= prov.characters.length) {
              return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()));
            }
            final c = prov.characters[index];
            return CharacterTile(
              character: c,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CharacterDetailScreen(id: c.id))),
            );
          },
        );
      }),
    );
  }
}
