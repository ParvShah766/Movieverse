import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;
  bool agree = false;
  bool loading = false;

  // ---------------- FIREBASE REGISTER ----------------
  Future<void> registerUser() async {
    try {
      setState(() => loading = true);

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // 🔥 SAVE USERNAME
      await userCredential.user!.updateDisplayName(
        usernameController.text.trim(),
      );
      await userCredential.user!.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } finally {
      setState(() => loading = false);
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
              child: SizedBox(width: 420, child: _glassCard()),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- GLASS CARD ----------------
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
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 24),

                _animated(_field(usernameController, "Username", Icons.person)),
                const SizedBox(height: 16),

                _animated(_emailField()),
                const SizedBox(height: 16),

                _animated(_passwordField(passwordController, "Password", true)),
                const SizedBox(height: 16),

                _animated(
                  _passwordField(
                    confirmPasswordController,
                    "Confirm Password",
                    false,
                  ),
                ),
                const SizedBox(height: 12),

                // ---------- TERMS & CONDITIONS ----------
                _animated(
                  Row(
                    children: [
                      Checkbox(
                        value: agree,
                        onChanged: (v) => setState(() => agree = v!),
                        activeColor: Colors.cyanAccent,
                      ),
                      Expanded(
                        child: Wrap(
                          children: [
                            const Text(
                              "I agree to the ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () => _showTermsDialog(context),
                              child: const Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ---------- REGISTER BUTTON ----------
                _animated(
                  SizedBox(
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
                              if (_formKey.currentState!.validate() && agree) {
                                registerUser();
                              } else if (!agree) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please accept Terms & Conditions",
                                    ),
                                  ),
                                );
                              }
                            },
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              "JOIN MOVIEVERSE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                _animated(
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Already Registered? LOGIN",
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

  // ---------------- ANIMATION ----------------
  Widget _animated(Widget child) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 30),
            child: child,
          ),
        );
      },
    );
  }

  // ---------------- FIELDS ----------------
  Widget _field(TextEditingController c, String label, IconData icon) {
    return TextFormField(
      controller: c,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle(label, icon),
      validator: (v) => v!.isEmpty ? "Required" : null,
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle("Email", Icons.email),
      validator: (v) {
        if (v == null || v.isEmpty) return "Email required";
        if (!v.contains("@")) return "Enter valid email";
        return null;
      },
    );
  }

  Widget _passwordField(TextEditingController c, String label, bool main) {
    return TextFormField(
      controller: c,
      obscureText: main ? hidePassword : hideConfirm,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle(
        label,
        Icons.lock,
        suffix: IconButton(
          icon: Icon(
            (main ? hidePassword : hideConfirm)
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () => setState(() {
            main ? hidePassword = !hidePassword : hideConfirm = !hideConfirm;
          }),
        ),
      ),
      validator: (v) {
        if (v == null || v.length < 6) return "Min 6 characters";
        if (!main && v != passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
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

  // ---------------- BACKGROUND ----------------
  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(color: Colors.black.withOpacity(0.7)),
    );
  }

  // ---------------- TERMS POPUP ----------------
  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.cyanAccent),
        ),
        content: const SingleChildScrollView(
          child: Text("""
1. This app provides movie information only.
2. We do not host or stream movies.
3. Content is sourced from third-party providers.
4. Availability may vary by region.
5. Misuse of content is prohibited.
6. We may update features anytime.
            """, style: TextStyle(color: Colors.white70)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "CLOSE",
              style: TextStyle(color: Colors.cyanAccent),
            ),
          ),
        ],
      ),
    );
  }
}
