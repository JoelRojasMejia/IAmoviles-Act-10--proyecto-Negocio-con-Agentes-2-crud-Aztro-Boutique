import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'config/theme.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aztro Boutique',
      debugShowCheckedModeBanner: false,

      /// 🔥 IMPORTANTE PARA QUE SE VEA IGUAL EN WEB
      themeMode: ThemeMode.light,

      /// 🎨 TU THEME
      theme: AppTheme.light,

      /// 👇 ESTO HACE QUE WEB USE MATERIAL CORRECTAMENTE
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const _NoGlowScroll(),
          child: child!,
        );
      },

      /// 🚀 INICIO CON WELCOME
      home: const WelcomeScreen(),
    );
  }
}

/// ❌ Quita el glow azul feo en Web (se ve más premium)
class _NoGlowScroll extends ScrollBehavior {
  const _NoGlowScroll();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
