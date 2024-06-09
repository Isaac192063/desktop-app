import 'package:desktop_app/gui/screens/admin_view/dashboard/util/constant.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/orders_lasts.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      alignment: Alignment.topRight,
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            OrderLasts(),
          ],
        ),
      ),
    );
  }
}
