import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(); // email
  final passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _buttonPulse;
  bool hidePassword = true;
  bool loading = false; // ✅ already existed

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _buttonPulse = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ------------------ FIREBASE LOGIN ------------------
  Future<void> loginUser() async {
    try {
      setState(() => loading = true); // ✅ FIX

      print("LOGIN STARTED");
      print("EMAIL: ${usernameController.text.trim()}");

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: usernameController.text.trim(),
            password: passwordController.text.trim(),
          );

      print("LOGIN SUCCESS: ${userCredential.user?.uid}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("FIREBASE ERROR: ${e.code} - ${e.message}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
    } finally {
      setState(() => loading = false); // ✅ FIX
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(width: 380, child: _glassCard()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "MOVIEVERSE",
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 30),

                _animatedField(
                  delay: 0.0,
                  child: _emailField(), // ✅ FIX
                ),
                const SizedBox(height: 16),

                _animatedField(delay: 0.2, child: _passwordField()),
                const SizedBox(height: 28),

                _animatedField(
                  delay: 0.4,
                  child: ScaleTransition(
                    scale: _buttonPulse,
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  loginUser(); // ✅ FIX
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                "ENTER CINEMA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _animatedField(
                  delay: 0.6,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "New here? CREATE ACCOUNT",
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ Animations ------------------
  Widget _animatedField({required double delay, required Widget child}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, Offset offset, _) {
        return Transform.translate(
          offset: offset * 60,
          child: Opacity(opacity: 1 - offset.dy, child: child),
        );
      },
    );
  }

  // ------------------ Fields ------------------
  Widget _emailField() {
    return TextFormField(
      controller: usernameController,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle("Email", Icons.email),
      validator: (v) {
        if (v == null || v.isEmpty) return "Email required";
        if (!v.contains("@")) return "Enter valid email";
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: hidePassword,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle(
        "Password",
        Icons.lock,
        suffix: IconButton(
          icon: Icon(
            hidePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () => setState(() => hidePassword = !hidePassword),
        ),
      ),
      validator: (v) => v!.length < 6 ? "Min 6 characters" : null,
    );
  }

  InputDecoration _inputStyle(String label, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.cyanAccent),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.cyanAccent),
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1524985069026-dd778a71c7b4",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(color: Colors.black.withOpacity(0.7)),
    );
  }
}
