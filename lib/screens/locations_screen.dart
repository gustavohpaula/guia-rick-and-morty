import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';
import 'residents_screen.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final prov = Provider.of<CharacterProvider>(context, listen: false);
    prov.loadLocationsInitial();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 200) {
        prov.loadMoreLocations();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locais')),
      body: Consumer<CharacterProvider>(builder: (context, prov, _) {
        if (prov.locations.isEmpty && prov.locationsLoading)
          return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          controller: _scrollController,
          itemCount: prov.locations.length + (prov.locationHasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= prov.locations.length)
              return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()));
            final loc = prov.locations[index];
            return ListTile(
              title: Text(loc.name),
              subtitle: Text(loc.type),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentsScreen(location: loc))),
            );
          },
        );
      }),
    );
  }
}
