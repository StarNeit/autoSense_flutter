import 'package:autosense/config/app_config.dart';
import 'package:autosense/features/app/app.dart';
import 'package:autosense/modules/bloc_observer/observer.dart';
import 'package:autosense/modules/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initEnvironment();

  // Removes leading # from the url running on web.
  setPathUrlStrategy();

  await configureDependencies();

  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    // Sets up allowed device orientations and other settings for the app.
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  // Sets system overylay style.
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );

  // This setting smoothes transition color for LinearGradient.
  Paint.enableDithering = true;

  // Set bloc observer and hydrated bloc storage.
  Bloc.observer = Observer();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: UniversalPlatform.isWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const App());
}
