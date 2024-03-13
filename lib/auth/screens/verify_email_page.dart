import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotes_for_you/navbar/navigation_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    // Check if the user's email is verified
    // ignore: unawaited_futures
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    // Send a verification email to the user
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResend = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      // show a snackbar if the email could not be sent
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Failed to send verification email'),
      // ));
      print('Failed to send verification email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const NavigationPage()
        : Scaffold(
            body: Center(
                child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Please verify your email address. A verification email has been sent to your email address.'),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    canResend ? sendVerificationEmail() : null;
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Resend Email',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )));
  }
}
