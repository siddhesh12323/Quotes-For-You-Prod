import 'package:flutter/material.dart';
import 'package:quotes_for_you/auth/screens/login_page.dart';
import 'package:quotes_for_you/auth/screens/sign_up_page.dart';

class LoginOrSignUpPage extends StatefulWidget {
  const LoginOrSignUpPage({super.key});

  @override
  State<LoginOrSignUpPage> createState() => _LoginOrSignUpPageState();
}

class _LoginOrSignUpPageState extends State<LoginOrSignUpPage> {
  bool showLoginPage = true;

  void toggleLoginOrSignUp() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        toggleLoginOrSignUp: toggleLoginOrSignUp,
      );
    } else {
      return SignUpPage(
        toggleLoginOrSignUp: toggleLoginOrSignUp,
      );
    }
  }
}
