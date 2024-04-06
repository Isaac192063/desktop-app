import 'package:fluent_ui/fluent_ui.dart';

void notification(BuildContext context, String message, String title,
    InfoBarSeverity icon) async {
  await displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: Text(title),
      content: Text(message),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: icon,
    );
  });
}
