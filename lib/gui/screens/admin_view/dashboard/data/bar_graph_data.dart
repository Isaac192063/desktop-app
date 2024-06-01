import 'package:desktop_app/gui/screens/admin_view/dashboard/model/bar_graph_model.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/model/graph_model.dart';
import 'package:flutter/material.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "Actividad de remisiones",
        color: Color(0xFFFEB95A),
        graph: [
          GraphModel(x: 0, y: 8),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 4),
          GraphModel(x: 4, y: 4),
          GraphModel(x: 5, y: 6),
        ]),
    const BarGraphModel(
        label: "Actividad re recepciones",
        color: Color(0xFFF2C8ED),
        graph: [
          GraphModel(x: 0, y: 8),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 9),
          GraphModel(x: 3, y: 6),
          GraphModel(x: 4, y: 6),
          GraphModel(x: 5, y: 7),
        ]),
  ];

  final label = ['M', 'T', 'W', 'T', 'F', 'S'];
}
