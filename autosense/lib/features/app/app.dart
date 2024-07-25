import 'package:autosense/features/fuel_finder/networking/station_repository.dart';
import 'package:autosense/features/fuel_finder/presentation/home_screen.dart';
import 'package:autosense/modules/dependency_injection/dependency_injection.dart';
import 'package:autosense/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<StationRepository>(
            create: (context) => getIt<StationRepository>(),
          ),
        ],
        child: MaterialApp(
          title: $constants.appTitle,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF4B3FA8),
              foregroundColor: Colors.white,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF4B3FA8),
              foregroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            cardTheme: const CardTheme(
              color: Color(0xFF4B3FA8),
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.black),
              bodyText2: TextStyle(color: Colors.black),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              elevation: 10,
            ),
          ),
          home: HomeScreen(),
        ));
  }
}
