import 'package:desktop_app/gui/widgets/notification.dart';
import 'package:fluent_ui/fluent_ui.dart';

Widget option(context) {
  final menuController = FlyoutController();
  return FlyoutTarget(
      controller: menuController,
      child: Button(
        child: const Row(children: [
          Icon(FluentIcons.account_management, size: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              "Mi cuenta",
              style: TextStyle(fontSize: 16),
            ),
          )
        ]),
        onPressed: () {
          menuController.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.left,
            ),
            barrierDismissible: true,
            dismissOnPointerMoveAway: false,
            dismissWithEsc: true,
            // navigatorKey: rootNavigatorKey.currentState,
            builder: (context) {
              return MenuFlyout(items: [
                const MenuFlyoutSeparator(),
                MenuFlyoutItem(
                  leading: const Icon(FluentIcons.sign_out),
                  text: const Text(
                    'Cerrar secion',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    notification(context, "secion cerrada", "Success",
                        InfoBarSeverity.success);
                    Navigator.popAndPushNamed(context, "/");
                    Flyout.of(context).close;
                  },
                ),
              ]);
            },
          );
        },
      ));
}
