import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterTile({super.key, required this.character, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(character.image)),
      title: Text(character.name),
      subtitle: Text('${character.species} • ${character.status}'),
      onTap: onTap,
    );
  }
}
