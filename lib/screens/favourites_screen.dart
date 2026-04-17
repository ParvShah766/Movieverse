import 'package:flutter/material.dart';
import '../utils/favourites_store.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: favouritesNotifier,
      builder: (context, favouriteMovies, _) {
        if (favouriteMovies.isEmpty) {
          return const Center(
            child: Text(
              "No favourites yet ❤️",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: favouriteMovies.map((movie) {
            return Card(
              color: Colors.grey.shade900,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.movie, color: Colors.cyanAccent),
                title: Text(
                  movie["title"]!,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${movie["review"]}\nIMDb ${movie["imdb"]}",
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    final updated = List<Map<String, String>>.from(
                      favouriteMovies,
                    );
                    updated.remove(movie);
                    favouritesNotifier.value = updated;
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
