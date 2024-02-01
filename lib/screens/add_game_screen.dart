// lib/screens/add_game_screen.dart
import 'package:flutter/material.dart';
import 'package:game_lib/controllers/game_controller.dart';
import 'package:game_lib/models/game.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({Key? key}) : super(key: key);

  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _platformController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _platformController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _platformController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Jogo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _platformController,
                decoration: const InputDecoration(labelText: 'Plataforma'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newGame = Game(
                      name: _nameController.text,
                      platform: _platformController.text,
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                    );
                    GameController gameController = GameController();

                    gameController.insertGame(newGame);

                    // Agora você pode fazer o que quiser com o objeto newGame
                    // Por exemplo, salvá-lo no banco de dados ou enviá-lo para o servidor
                    // Resetar os controladores para limpar os campos do formulário
                    _nameController.clear();
                    _platformController.clear();
                    _descriptionController.clear();
                    _imageUrlController.clear();
                    // Exibir uma mensagem ou navegar para outra tela se necessário
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Jogo salvo com sucesso!')),
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (ok) {
                      return false;
                    });
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
