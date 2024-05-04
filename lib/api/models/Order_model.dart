
import 'package:flutter/material.dart';

class Order {
  final double cantidad;
  final String descripcion;
  final String numeroEnvase;
  final String propietario;
  final String lote;
  final String fechaVen;
  final int valorUnitario;

  const Order(
      {required this.cantidad,
      required this.descripcion,
      required this.numeroEnvase,
      required this.propietario,
      required this.lote,
      required this.fechaVen,
      required this.valorUnitario});
}

const orderListItems = <Order>[
  Order(
    cantidad: 6.5,
    descripcion: 'OXIND', 
    numeroEnvase: '5127864', 
    propietario: 'MENDEZ', 
    lote: '', 
    fechaVen: '',  
    valorUnitario: 70000,
  ),
  Order(
    cantidad: 6.5,
    descripcion: 'OXIND', 
    numeroEnvase: '9200033391', 
    propietario: 'RDQ', 
    lote: '', 
    fechaVen: '',  
    valorUnitario: 70000,
  ),
  Order(
    cantidad: 6.5,
    descripcion: 'OXIND', 
    numeroEnvase: '3638342Y', 
    propietario: 'RDQ', 
    lote: '', 
    fechaVen: '',  
    valorUnitario: 70000,
  ),
  Order(
    cantidad: 6.5,
    descripcion: 'OXIND', 
    numeroEnvase: '3638342Y', 
    propietario: 'RDQ', 
    lote: '', 
    fechaVen: '',  
    valorUnitario: 70000,
  ),
  Order(
    cantidad: 6.5,
    descripcion: 'OXIND', 
    numeroEnvase: '3638342Y', 
    propietario: 'RDQ', 
    lote: '', 
    fechaVen: '',  
    valorUnitario: 70000,
  ),

];
