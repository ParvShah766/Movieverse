import 'package:flutter/material.dart';
import 'login_page.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';
import 'language_screen.dart';
import '../utils/favourites_store.dart';
import 'profile_screen.dart'; // ✅ FIXED: semicolon added

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeTab(),
    CategoriesTab(),
    LanguageScreen(),
    FavouritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("MOVIEVERSE"),
        actions: [
          // 👤 PROFILE ICON (NOW CLICKABLE)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade800,
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.cyanAccent,
                ),
              ),
            ),
          ),

          // 🔴 LOGOUT
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.cyanAccent),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: pages[currentIndex],

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: "Language",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}

/* ============================================================
                          HOME TAB
============================================================ */

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          "🔥 Popular Movies",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
        ),
        SizedBox(height: 12),

        MovieCard(
          title: "Inception",
          review: "Mind-bending sci-fi thriller",
          imdb: "8.8",
        ),
        MovieCard(
          title: "The Dark Knight",
          review: "Iconic superhero crime thriller",
          imdb: "9.0",
        ),
        MovieCard(
          title: "Interstellar",
          review: "Epic space exploration drama",
          imdb: "8.6",
        ),
        MovieCard(
          title: "3 Idiots",
          review: "Inspirational & entertaining",
          imdb: "8.4",
        ),
        MovieCard(
          title: "Forrest Gump",
          review: "Heartwarming life journey",
          imdb: "8.8",
        ),
        MovieCard(
          title: "Avengers: Endgame",
          review: "Epic superhero finale",
          imdb: "8.4",
        ),
        MovieCard(
          title: "Parasite",
          review: "Social satire thriller",
          imdb: "8.5",
        ),
        MovieCard(
          title: "Joker",
          review: "Psychological character drama",
          imdb: "8.4",
        ),
        MovieCard(
          title: "Gladiator",
          review: "Powerful historical epic",
          imdb: "8.5",
        ),
        MovieCard(
          title: "KGF Chapter 2",
          review: "High-octane action drama",
          imdb: "8.3",
        ),
      ],
    );
  }
}

/* ============================================================
                        MOVIE CARD
============================================================ */

class MovieCard extends StatelessWidget {
  final String title;
  final String review;
  final String imdb;

  const MovieCard({
    super.key,
    required this.title,
    required this.review,
    required this.imdb,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: favouritesNotifier,
      builder: (context, favourites, _) {
        final isFav = favourites.any((movie) => movie["title"] == title);

        return Card(
          color: Colors.grey.shade900,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.movie, color: Colors.cyanAccent),
            title: Text(title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              "$review\nIMDb $imdb",
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.cyanAccent,
              ),
              onPressed: () {
                final updated = List<Map<String, String>>.from(favourites);

                if (isFav) {
                  updated.removeWhere((movie) => movie["title"] == title);
                } else {
                  updated.add({"title": title, "review": review, "imdb": imdb});
                }

                favouritesNotifier.value = updated;
              },
            ),
          ),
        );
      },
    );
  }
}
