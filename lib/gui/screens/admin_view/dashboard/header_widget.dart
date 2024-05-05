import 'package:desktop_app/gui/utils/myColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class headerWidget extends StatefulWidget {
  const headerWidget({super.key});

  @override
  State<headerWidget> createState() => _headerWidgetState();
}

class _headerWidgetState extends State<headerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColor.primaryKey,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          hintText: 'Buscar por envase',
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 21,
          ),
        ),
      ),
    );
  }
}
