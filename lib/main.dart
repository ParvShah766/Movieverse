import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// 👇 IMPORT YOUR SCREENS
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 FIREBASE INITIALIZATION (WEB)
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    
      apiKey: "AIzaSyCLczFTm2YURvMg_PHXSBIOTNK5u5ZMuSs",
      authDomain: "movieverse-d3145.firebaseapp.com",
      projectId: "movieverse-d3145",
      storageBucket: "movieverse-d3145.firebasestorage.app",
      messagingSenderId: "713551224124",
      appId: "1:713551224124:web:42b6e2d7e1706523631239",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieVerse',
      theme: ThemeData.dark(),
      home: const SplashScreen(), // 👈 SPLASH FIRST
      routes: {'/login': (_) => const LoginPage()},
    );
  }
}
