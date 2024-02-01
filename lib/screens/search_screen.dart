// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:game_lib/controllers/game_controller.dart';
import 'package:game_lib/models/game.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Game> games = [];

  final GameController _controller = GameController();

  @override
  void initState() {
    getAllGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Jogos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) async {
                      games = await _controller.filterGames(value, '');
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar',
                      hintText: 'Nome ou descrição do jogo',
                    ),
                  ),
                ),
                // const SizedBox(width: 16.0),
                // DropdownButton<String>(
                //   value: _selectedPlatform,
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedPlatform = value!;
                //     });
                //   },
                //   items: _buildPlatformDropdownItems(),
                //   hint: const Text('Plataforma'),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  leading: Image.network(
                    game.imageUrl,
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(game.name),
                  subtitle: Text(game.platform),
                  onTap: () {
                    // Navegar para a tela de detalhes do jogo quando um item é tocado
                    Navigator.pushNamed(context, '/game_detail',
                        arguments: game);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildPlatformDropdownItems() {
    // Lista de plataformas únicas a partir da lista de jogos
    final platforms = games.map((game) => game.platform).toSet().toList();
    platforms.add('Todas');

    return platforms.map((platform) {
      return DropdownMenuItem<String>(
        value: platform,
        child: Text(platform),
      );
    }).toList();
  }

  void getAllGames() async {
    games = await _controller.getAllGames();
    setState(() {});
  }
}
