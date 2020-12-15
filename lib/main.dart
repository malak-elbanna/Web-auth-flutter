import 'package:auth_web/screens/auth_screen.dart';
import 'package:auth_web/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web Auth',
      theme: ThemeData(primaryColor: Colors.red),
      home: FutureBuilder<Object>(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            return StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, user) {
                  if (user.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (!user.hasData) return AuthScreen();
                  return HomeScreen();
                });
          }),
    );
  }
}
