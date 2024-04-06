import 'package:fluent_ui/fluent_ui.dart';

void notification(BuildContext context, String message) async {
  await displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: const Text('Error:'),
      content: Text(message),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: InfoBarSeverity.warning,
    );
  });
}
