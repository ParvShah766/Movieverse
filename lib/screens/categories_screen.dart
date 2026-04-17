import 'package:flutter/material.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        CategoryBlock(
          title: "🏆 Sports",
          movies: [
            "MS Dhoni – The Untold Story (IMDb 7.9)",
            "Chak De! India (IMDb 8.1)",
            "Dangal (IMDb 8.3)",
            "Lagaan (IMDb 8.1)",
            "Million Dollar Baby (IMDb 8.1)",
            "Rush (IMDb 8.1)",
            "Ford v Ferrari (IMDb 8.1)",
            "Creed (IMDb 7.6)",
            "Moneyball (IMDb 7.6)",
            "Iqbal (IMDb 8.1)",
          ],
        ),
        CategoryBlock(
          title: "❤️ Romance",
          movies: [
            "Titanic (IMDb 7.9)",
            "La La Land (IMDb 8.0)",
            "The Notebook (IMDb 7.8)",
            "DDLJ (IMDb 8.0)",
            "Before Sunrise (IMDb 8.1)",
            "Pride & Prejudice (IMDb 7.8)",
            "Veer-Zaara (IMDb 7.8)",
            "A Walk to Remember (IMDb 7.4)",
            "Romeo + Juliet (IMDb 6.7)",
            "Notting Hill (IMDb 7.1)",
          ],
        ),
        CategoryBlock(
          title: "🎭 Drama",
          movies: [
            "Forrest Gump (IMDb 8.8)",
            "3 Idiots (IMDb 8.4)",
            "Parasite (IMDb 8.5)",
            "Joker (IMDb 8.4)",
            "The Shawshank Redemption (IMDb 9.3)",
            "Fight Club (IMDb 8.8)",
            "The Green Mile (IMDb 8.6)",
            "Taare Zameen Par (IMDb 8.4)",
            "Whiplash (IMDb 8.5)",
            "Slumdog Millionaire (IMDb 8.0)",
          ],
        ),
        CategoryBlock(
          title: "😱 Thriller",
          movies: [
            "Inception (IMDb 8.8)",
            "Shutter Island (IMDb 8.2)",
            "Se7en (IMDb 8.6)",
            "Gone Girl (IMDb 8.1)",
            "Prisoners (IMDb 8.1)",
            "Zodiac (IMDb 7.7)",
            "Black Swan (IMDb 8.0)",
            "Nightcrawler (IMDb 7.8)",
            "Andhadhun (IMDb 8.2)",
            "Drishyam (IMDb 8.2)",
          ],
        ),
        CategoryBlock(
          title: "👻 Horror",
          movies: [
            "The Conjuring (IMDb 7.5)",
            "It (IMDb 7.3)",
            "A Quiet Place (IMDb 7.5)",
            "Hereditary (IMDb 7.3)",
            "Insidious (IMDb 6.8)",
            "The Exorcist (IMDb 8.1)",
            "Sinister (IMDb 6.8)",
            "The Ring (IMDb 7.1)",
            "The Babadook (IMDb 6.8)",
            "Lights Out (IMDb 6.3)",
          ],
        ),
        CategoryBlock(
          title: "😂 Comedy",
          movies: [
            "Hera Pheri (IMDb 8.2)",
            "The Hangover (IMDb 7.7)",
            "PK (IMDb 8.1)",
            "3 Idiots (IMDb 8.4)",
            "Home Alone (IMDb 7.7)",
            "Superbad (IMDb 7.6)",
            "Step Brothers (IMDb 6.9)",
            "Deadpool (IMDb 8.0)",
            "Munna Bhai M.B.B.S (IMDb 8.1)",
            "Welcome (IMDb 7.1)",
          ],
        ),
      ],
    );
  }
}

/* ================= CATEGORY BLOCK ================= */

class CategoryBlock extends StatelessWidget {
  final String title;
  final List<String> movies;

  const CategoryBlock({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
            const SizedBox(height: 10),
            ...movies.map(
              (movie) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.movie, size: 18, color: Colors.cyanAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        movie,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
