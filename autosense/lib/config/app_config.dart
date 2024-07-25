import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig extends InheritedWidget {
  final String appTitle;

  const AppConfig({
    Key? key,
    required Widget child,
    required this.appTitle,
  }) : super(key: key, child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static Future<void> initEnvironment() async {
    await dotenv.load();
  }

  static String getEnv(String key) {
    return dotenv.env[key] ?? '';
  }
}
