import 'package:auth_web/widgets/custom_button.dart';
import 'package:auth_web/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isSignUp = false;

  String _email = '';
  String _password = '';

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 48),
            InputField(
              label: 'Email',
              icon: Icons.email,
              validator: (value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                if (value.trim().isEmpty)
                  return 'You have to enter the email';
                else if (!regExp.hasMatch(value.trim()))
                  return 'Please enter a valid email';
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 24),
            InputField(
              label: 'Password',
              icon: Icons.lock,
              validator: (value) {
                if (value.trim().isEmpty)
                  return 'You have to enter the password';
                else if (value.trim().length < 6)
                  return 'Password should be at least 6 characters';
                return null;
              },
              onChanged: (value) {
                _password = value.trim();
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            if (_isSignUp) ...[
              const SizedBox(height: 24),
              InputField(
                label: 'Confirm Password',
                icon: Icons.lock,
                validator: (value) {
                  if (value.trim().isEmpty)
                    return 'You have to enter the password again';
                  else if (value.trim() != _password)
                    return 'Password does not match';
                  return null;
                },
              ),
            ],
            const SizedBox(height: 24),
            CustomButton(
              isLoading: _isLoading,
              text: _isSignUp ? 'Sign up' : 'Sign in',
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState.validate()) {
                        // The data entered in the form are valid
                        _formKey.currentState.save();

                        setState(() {
                          _isLoading = true;
                        });

                        if (_isSignUp) {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _email, password: _password);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              setState(() {
                                _errorMessage =
                                    'The password provided is too weak';
                              });
                            } else if (e.code == 'email-already-in-use') {
                              setState(() {
                                _errorMessage =
                                    'The account already exists for that email';
                              });
                            }
                          } catch (e) {} finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              setState(() {
                                _errorMessage = 'No user found for that email';
                              });
                            } else if (e.code == 'wrong-password') {
                              setState(() {
                                _errorMessage =
                                    'Wrong password provided for that user';
                              });
                            }
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      }
                    },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignUp
                      ? 'Do you have an account?'
                      : 'Does not have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                FlatButton(
                  child: Text(
                    _isSignUp ? 'Sign in now' : 'Sign up now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    // Switch the form from sign in to sign up and vice versa
                    if (_isSignUp)
                      setState(() => _isSignUp = false);
                    else
                      setState(() => _isSignUp = true);
                  },
                ),
              ],
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                _errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
