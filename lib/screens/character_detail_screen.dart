import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/loading_widget.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int id;
  const CharacterDetailScreen({super.key, required this.id});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  bool _loading = true;
  dynamic _error;
  dynamic _character;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final prov = Provider.of<CharacterProvider>(context, listen: false);
      final c = await prov.getById(widget.id);
      setState(() {
        _character = c;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favProv = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: _loading
          ? const LoadingWidget()
          : (_error != null
              ? Center(child: Text('Erro: \$_error'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(_character.image, height: 250),
                      const SizedBox(height: 12),
                      Text(_character.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Status: \${_character.status}'),
                      Text('Espécie: \${_character.species}'),
                      Text('Gênero: \${_character.gender}'),
                      Text('Origem: \${_character.originName}'),
                      Text('Localização: \${_character.locationName}'),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: Icon(favProv.isFavorite(_character.id)
                            ? Icons.favorite
                            : Icons.favorite_border),
                        label: Text(favProv.isFavorite(_character.id)
                            ? 'Remover dos favoritos'
                            : 'Adicionar aos favoritos'),
                        onPressed: () async {
                          await favProv.toggleFavorite(_character.id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                )),
    );
  }
}
