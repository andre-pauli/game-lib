// lib/screens/game_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:game_lib/controllers/game_controller.dart';
import 'package:game_lib/models/game.dart';

class GameDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenha o objeto Game passado como argumento
    final Game game = ModalRoute.of(context)!.settings.arguments as Game;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                game.imageUrl,
                height: 300.0,
                width: 300.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                game.name,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(game.platform,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              Text(
                game.description,
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              // Adicione o botão Excluir Game com ícone de lixeira
              ElevatedButton.icon(
                onPressed: () {
                  GameController gameController = GameController();
                  gameController.deleteGame(game);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jogo excluído com sucesso!')),
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (ok) {
                    return false;
                  });
                },
                icon: const Icon(Icons.delete),
                label: const Text('Excluir Game'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Cor de fundo do botão
                  onPrimary: Colors.white, // Cor do texto no botão
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
