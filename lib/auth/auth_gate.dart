import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotes_for_you/auth/screens/login_or_signup.dart';
import 'package:quotes_for_you/auth/screens/login_page.dart';
import 'package:quotes_for_you/navbar/navigation_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in
            if (snapshot.hasData) {
              return const NavigationPage();
            } else {
              return const LoginOrSignUpPage();
            }
          }),
    );
  }
}
