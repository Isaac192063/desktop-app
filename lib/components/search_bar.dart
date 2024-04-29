import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class Cat {
  final int id;
  final String name;
  final bool hasTag;

  const Cat(this.id, this.name, this.hasTag);
}

class _SearchbarState extends State<Searchbar> {
  List<Cat> objectCats = const [
    Cat(1, 'Abyssinian', true),
    Cat(2, 'Aegean', true),
    Cat(3, 'American Bobtail', false),
    Cat(4, 'American Curl', true),
    Cat(5, 'American Ringtail', false),
    Cat(6, 'American Shorthair', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: AutoSuggestBox(
          selectionWidthStyle: BoxWidthStyle.max,
          placeholder: "Buscar en inventario",
          leadingIcon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(FluentIcons.search),
          ),
          items: objectCats
              .map<AutoSuggestBoxItem<Cat>>(
                (cat) => AutoSuggestBoxItem<Cat>(
                  value: cat,
                  label: cat.name,
                  onFocusChange: (focused) {
                    if (focused) {
                      debugPrint('Focused #${cat.id} - ${cat.name}');
                    }
                  },
                ),
              )
              .toList(),
          onSelected: null),
    );
  }
}
