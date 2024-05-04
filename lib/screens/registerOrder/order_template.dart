import 'package:desktop_app/screens/registerOrder/indexOrder.dart';
import 'package:desktop_app/screens/registerOrder/registerOrder.dart';
import 'package:flutter/material.dart';

class OrderTemplate extends StatefulWidget {
  final int crud;
  const OrderTemplate({super.key,required this.crud});

  @override
  State<OrderTemplate> createState() => _OrderTemplateState();
  
}

class _OrderTemplateState extends State<OrderTemplate> {
  

  @override
  Widget build(BuildContext context) {
    if (widget.crud == 0){
      return const IndexOrder();
    }else if(widget.crud == 1){
      return const RegisterOrder();
    }else{
      return const Placeholder();
    }
  }
}