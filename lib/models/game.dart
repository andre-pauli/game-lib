class Game {
  final String name;
  final String platform;
  final String description;
  final String imageUrl;

  Game({
    required this.name,
    required this.platform,
    required this.description,
    required this.imageUrl,
  });

  // Construtor de fábrica para desserialização
  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      name: map['name'],
      platform: map['platform'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  // Método para serialização
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'platform': platform,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
