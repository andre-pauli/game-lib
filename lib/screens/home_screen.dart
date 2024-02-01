// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:game_lib/controllers/game_controller.dart';
import 'package:game_lib/models/game.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text('Adicionados recentemente'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: games.isEmpty
                ? const SizedBox(
                    child: Center(
                      child: Text(
                        'Você ainda não cadastrou \n nenhum jogo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: games.length > 1,
                        height: MediaQuery.of(context).size.height * 0.9),
                    items: games.map((game) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/game_detail',
                                  arguments: game);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(
                                game.imageUrl,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_game');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Text('Adicionar Novo Jogo'),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Text('Buscar Jogos'),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  void getAllGames() async {
    games = await _controller.getAllGames();
    setState(() {});
  }
}
