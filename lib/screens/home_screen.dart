import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              'Sign out',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              // Sign out User
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
