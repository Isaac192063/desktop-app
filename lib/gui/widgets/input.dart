import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final Icon icon;
  final TextEditingController controller;

  const CustomInput({
    Key? key,
    required this.label,
    required this.validator,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          labelText: label,
          counterStyle: TextStyle(fontSize: 26),
          prefixIcon: icon,
          alignLabelWithHint: false,
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          hoverColor: Colors.transparent,
        ),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
