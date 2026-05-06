import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'admin/productos_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Boutique Panel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Ir al CRUD de Productos"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductosList()),
            );
          },
        ),
      ),
    );
  }
}