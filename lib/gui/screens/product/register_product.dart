import 'package:desktop_app/domain/models/Product.dart';
import 'package:desktop_app/domain/service/Product_service.dart';
import 'package:desktop_app/gui/screens/product/ProductController.dart';
import 'package:desktop_app/gui/widgets/input.dart';
import 'package:desktop_app/gui/widgets/textModified.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class Register_edit_packaging extends StatefulWidget {
  final ProductController _con;
  final GlobalKey<FormState> formKey;
  final bool update;
  const Register_edit_packaging(this._con, this.formKey, this.update,
      {super.key});

  @override
  State<Register_edit_packaging> createState() => _nameState();
}

class _nameState extends State<Register_edit_packaging> {
  late Future<List<TypePackaging>> listProductsType;
  late Future<List<Content>> listContent;
  final Productservice productService = Productservice();
  DateTime? selected;
  GlobalKey<FormState>? formKey;

  ProductController? _con;

  TypePackaging? typePackagaging;
  Content? content;
  bool? update;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    listProductsType = productService.getAllTypeContent();
    listContent = productService.getAllContent();
    _con = widget._con;
    content = _con!.content;
    typePackagaging = _con!.typePackaging;
    selected = _con!.time;
    _con?.context = context;
    formKey = widget.formKey;
    update = widget.update;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              !update!
                  ? Material(
                      child: CustomInput(
                          label: 'Codigo del cilindro',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el codigo de cilindro';
                            }

                            return null;
                          },
                          icon: Icon(Icons.code),
                          controller: _con!.cod),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Material(
                child: CustomInput(
                    label: 'Dueño del cilindro',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el dueño del cilindro';
                      }
                      return null;
                    },
                    icon: Icon(Icons.person_4_rounded),
                    controller: _con!.owner),
              ),
              const SizedBox(
                height: 20,
              ),
              checkBoxContent(listContent, "seleccione el contenido"),
              const SizedBox(
                height: 10,
              ),
              checkBoxType(listProductsType, "seleccione el tamaño"),
              const SizedBox(
                height: 20,
              ),
              DatePicker(
                header: 'Prueba hidrostatica',
                selected: selected,
                headerStyle: const TextStyle(fontSize: 18),
                contentPadding: const EdgeInsets.all(5),
                onChanged: (time) => setState(() {
                  _con!.time = time;
                  selected = time;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBoxType(Future<List<TypePackaging>> list, String title) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Iterable<TypePackaging> typePackaging = snapshot.data!.where(
            (element) {
              final isCO2 = content?.name == "CO2";
              final isKG = element.pressureAmount == "KG";
              return isCO2 ? isKG : !isKG;
            },
          );

          List<TypePackaging> listPackaging = typePackaging.toList();

          return ComboBox<TypePackaging>(
            value: typePackagaging,
            items: listPackaging.map<ComboBoxItem<TypePackaging>>((e) {
              return ComboBoxItem<TypePackaging>(
                value: e,
                child: Text("${e.size.toString()} ${e.pressureAmount}"),
              );
            }).toList(),
            onChanged: disabled
                ? null
                : (color) {
                    _con?.typePackaging = color;
                    setState(() {
                      typePackagaging = color;
                    });
                  },
            placeholder: typePackagaging == null
                ? textModified(title, 16)
                : Text(
                    "${typePackagaging!.size.toString()} ${typePackagaging!.pressureAmount}"),
          );
        }

        return ProgressRing();
      },
    );
  }

  Widget checkBoxContent(Future<List<Content>> list, String title) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Content> listPackaging = snapshot.data!;
          return ComboBox<Content>(
            value: content,
            items: listPackaging.map<ComboBoxItem<Content>>((e) {
              return ComboBoxItem<Content>(
                child: Text(e.name!),
                value: e,
              );
            }).toList(),
            onChanged: disabled
                ? null
                : (color) {
                    _con!.content = color!;
                    setState(() => content = color);
                  },
            placeholder: content == null
                ? textModified(title, 16)
                : Text(content!.name!),
          );
        }

        return ProgressRing();
      },
    );
  }
}
