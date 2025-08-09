import 'package:authentication/pages/home_page.dart';
import 'package:authentication/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPages extends StatelessWidget {
  const AuthPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          //user is not login in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
