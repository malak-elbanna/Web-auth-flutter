import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;

  const CustomButton(
      {@required this.text, @required this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: RaisedButton(
          elevation: 0,
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(fontSize: 18),
                ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
