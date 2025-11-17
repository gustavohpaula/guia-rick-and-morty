import 'package:flutter/material.dart';
import '../models/location.dart';
import '../services/api_service.dart';
import '../widgets/loading_widget.dart';
import 'character_detail_screen.dart';

class ResidentsScreen extends StatefulWidget {
  final RMLocation location;
  const ResidentsScreen({super.key, required this.location});

  @override
  State<ResidentsScreen> createState() => _ResidentsScreenState();
}

class _ResidentsScreenState extends State<ResidentsScreen> {
  final ApiService _api = ApiService();
  bool loading = true;
  dynamic error;
  List<dynamic> residents = [];

  @override
  void initState() {
    super.initState();
    _loadResidents();
  }

  Future<void> _loadResidents() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final list =
          await _api.fetchMultipleCharactersByUrls(widget.location.residents);
      residents = list;
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.location.name)),
      body: loading
          ? const LoadingWidget()
          : (error != null
              ? Center(child: Text('Erro: \$error'))
              : ListView.builder(
                  itemCount: residents.length,
                  itemBuilder: (context, i) {
                    final c = residents[i];
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
                )),
    );
  }
}
