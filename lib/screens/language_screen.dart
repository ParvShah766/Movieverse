import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "🎬 Watch in Your Language",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 16),
          _languageTile(context, "Hindi"),
          _languageTile(context, "English"),
          _languageTile(context, "Gujarati"),
        ],
      ),
    );
  }

  Widget _languageTile(BuildContext context, String language) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.movie, color: Colors.cyanAccent),
        title: Text(
          language,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LanguageMoviesScreen(language: language),
            ),
          );
        },
      ),
    );
  }
}

/* ================= LANGUAGE MOVIES SCREEN ================= */

class LanguageMoviesScreen extends StatelessWidget {
  final String language;

  const LanguageMoviesScreen({super.key, required this.language});

  static final Map<String, List<Map<String, String>>> moviesByLanguage = {
    "Hindi": [
      {"name": "3 Idiots", "review": "Inspirational comedy", "imdb": "8.4"},
      {"name": "Dangal", "review": "Sports drama", "imdb": "8.3"},
      {"name": "PK", "review": "Satirical comedy", "imdb": "8.1"},
      {"name": "Lagaan", "review": "Period sports drama", "imdb": "8.1"},
      {"name": "Andhadhun", "review": "Dark thriller", "imdb": "8.2"},
      {"name": "Drishyam", "review": "Crime thriller", "imdb": "8.2"},
      {"name": "Swades", "review": "Emotional drama", "imdb": "8.2"},
      {"name": "Gully Boy", "review": "Music drama", "imdb": "7.9"},
      {"name": "Taare Zameen Par", "review": "Emotional drama", "imdb": "8.4"},
      {
        "name": "Bajrangi Bhaijaan",
        "review": "Heart-touching drama",
        "imdb": "8.0",
      },
    ],
    "English": [
      {"name": "Inception", "review": "Sci-fi thriller", "imdb": "8.8"},
      {"name": "Interstellar", "review": "Space drama", "imdb": "8.6"},
      {"name": "The Dark Knight", "review": "Crime thriller", "imdb": "9.0"},
      {"name": "Forrest Gump", "review": "Life journey", "imdb": "8.8"},
      {"name": "Fight Club", "review": "Psychological drama", "imdb": "8.8"},
      {"name": "Se7en", "review": "Serial killer thriller", "imdb": "8.6"},
      {"name": "Gladiator", "review": "Historical epic", "imdb": "8.5"},
      {"name": "The Matrix", "review": "Sci-fi action", "imdb": "8.7"},
      {"name": "Joker", "review": "Psychological drama", "imdb": "8.4"},
      {"name": "Titanic", "review": "Romantic drama", "imdb": "7.9"},
    ],
    "Gujarati": [
      {"name": "Chhello Divas", "review": "College life", "imdb": "8.2"},
      {"name": "Hellaro", "review": "Cultural drama", "imdb": "8.3"},
      {"name": "Wrong Side Raju", "review": "Courtroom drama", "imdb": "8.0"},
      {"name": "Bey Yaar", "review": "Friendship drama", "imdb": "7.9"},
      {"name": "Ventilator", "review": "Family drama", "imdb": "8.4"},
      {"name": "Reva", "review": "Romantic drama", "imdb": "7.8"},
      {"name": "Love Ni Bhavai", "review": "Romantic drama", "imdb": "8.1"},
      {"name": "Shu Thayu", "review": "Youth drama", "imdb": "7.9"},
      {"name": "Gujjubhai The Great", "review": "Comedy drama", "imdb": "7.4"},
      {"name": "Natsamrat", "review": "Powerful drama", "imdb": "8.7"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final movies = moviesByLanguage[language]!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("$language Movies"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            color: Colors.grey.shade900,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.movie, color: Colors.cyanAccent),
              title: Text(
                movie["name"]!,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "${movie["review"]}\nIMDb ${movie["imdb"]}",
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.favorite_border,
                color: Colors.cyanAccent,
              ),
            ),
          );
        },
      ),
    );
  }
}
