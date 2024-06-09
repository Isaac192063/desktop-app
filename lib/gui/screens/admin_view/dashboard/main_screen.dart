import 'package:desktop_app/gui/screens/admin_view/dashboard/util/responsive.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/dashboard_widget.dart';
import 'package:desktop_app/gui/screens/admin_view/dashboard/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const SummaryWidget(),
            )
          : null,
      body: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DashboardWidget(),
                ],
              ),
            ),
            if (isDesktop)
              const Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryWidget(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
