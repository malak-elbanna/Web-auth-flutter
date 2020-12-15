import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function validator;
  final Function onSaved;
  final Function onChanged;

  const InputField({
    this.label,
    this.icon,
    this.onChanged,
    this.onSaved,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
