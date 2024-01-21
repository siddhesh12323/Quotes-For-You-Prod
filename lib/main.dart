import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_for_you/navbar/navigation_page.dart';
import 'package:quotes_for_you/screens/about_page.dart';
import 'package:quotes_for_you/screens/favorites_page.dart';
import 'package:quotes_for_you/screens/settings_page.dart';
import 'local/favorites_manager.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FavoritesManager()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes For You',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const NavigationPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
