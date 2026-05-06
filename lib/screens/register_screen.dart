import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nombre = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  final auth = AuthService();

  bool loading = false;

  void register() async {
    setState(() => loading = true);

    try {
      await auth.register(
        email.text.trim(),
        pass.text.trim(),
        nombre.text.trim(),
      );

      if (!mounted) return;

      /// 🔥 NO usamos Navigator
      /// FirebaseAuth detecta sesión automáticamente
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registro exitoso")));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    nombre.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Crear Cuenta",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(
                    labelText: "Nombre completo",
                  ),
                ),

                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),

                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 20),

                loading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: register,
                          child: const Text("Registrar"),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
