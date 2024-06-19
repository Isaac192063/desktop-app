import 'package:flutter/material.dart';

class CustomPasswordInput extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final Icon icon;
  final TextEditingController controller;

  const CustomPasswordInput({
    Key? key,
    required this.label,
    required this.validator,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _obscureText = false;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: !_obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          contentPadding: EdgeInsets.all(8),
          counterStyle: TextStyle(fontSize: 26),
          prefixIcon: widget.icon,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _toggleVisibility,
          ),
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
