import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_for_you/navbar/navigation_page.dart';
import 'package:quotes_for_you/screens/about_page.dart';
import 'package:quotes_for_you/screens/favorites_page.dart';
import 'package:quotes_for_you/screens/login_page.dart';
import 'package:quotes_for_you/screens/settings_page.dart';
import 'package:quotes_for_you/screens/sign_up_page.dart';
import 'local/favorites_manager.dart';
import 'theme/theme_manager.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FavoritesManager()),
    ChangeNotifierProvider(create: (_) => ThemeManager()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeManager themeManager, child) {
        return MaterialApp(
          title: 'Quotes For You',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: themeManager.chosenColor,
              fontFamily: themeManager.chosenFont),
          darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: themeManager.chosenColor,
              fontFamily: themeManager.chosenFont),
          routes: {
            '/navigation': (context) => const NavigationPage(),
            '/favorites': (context) => const FavoritesPage(),
            '/settings': (context) => SettingsPage(),
            '/about': (context) => const AboutPage(),
            '/shareasimage': (context) => const AboutPage(),
            '/login': (context) => const LoginPage(),
            '/signup': (context) => const SignUpPage(),
          },
          home: const LoginPage(),
        );
      },
    );
  }
}
