import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String review;
  final String imdb;
  final VoidCallback onFavourite;

  const MovieCard({
    super.key,
    required this.title,
    required this.review,
    required this.imdb,
    required this.onFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.movie, color: Colors.cyanAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          "$review\nIMDb Rating: $imdb",
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.cyanAccent),
          onPressed: onFavourite,
        ),
      ),
    );
  }
}
