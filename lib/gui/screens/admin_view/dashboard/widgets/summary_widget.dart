import 'package:desktop_app/gui/screens/admin_view/dashboard/util/constant.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/pie_chart_widget.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/scheduled_widget.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/summary_details.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Chart(),
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SummaryDetails(),
            SizedBox(height: 40),
            Scheduled(),
          ],
        ),
      ),
    );
  }
}
