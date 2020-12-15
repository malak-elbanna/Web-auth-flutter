import 'package:auth_web/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          // Form
          Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              constraints: BoxConstraints(
                maxWidth: 500,
                maxHeight: 600,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: AuthForm(),
            ),
          )
        ],
      ),
    );
  }
}
