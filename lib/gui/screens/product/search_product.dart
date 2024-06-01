import 'dart:async';
import 'package:desktop_app/config/response_api.dart';
import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPackaging extends StatefulWidget {
  final Function viewDetail;
  const SearchPackaging(this.viewDetail, {super.key});

  @override
  State<SearchPackaging> createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchPackaging> {
  final Productservice _prov = Productservice();
  final TextEditingController _searchController = TextEditingController();
  List<Packaging> listEmployees = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    fechProducts();
  }

  void fechProducts([String? query]) async {
    // print(query);

    if (query?.trim() == "") {
      List<Packaging> aux =
          await _prov.findPackagingByCod(_searchController.text);
      setState(() {
        listEmployees = aux;
      });
    } else {
      ResponseApi api = await _prov.getAllProducts();
      List aux = api.data;
      List<Packaging> aux2 = aux.map((e) => Packaging.fromJson(e)).toList();
      setState(() {
        listEmployees = aux2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSuggestBox<Packaging?>(
            onChanged: (text, reason) {
              _debouncer.run(() {
                fechProducts(text);
              });
            },
            style: TextStyle(fontSize: 16),
            controller: _searchController,
            placeholder: "Buscar envase",
            leadingIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(FluentIcons.search),
            ),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 252, 255, 254)),
            items: listEmployees.map((packaging) {
              return AutoSuggestBoxItem<Packaging>(
                  value: packaging, label: packaging.id!);
            }).toList(),
            onSelected: (value) {
              widget.viewDetail(context, value.value);
            },
          ),
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
