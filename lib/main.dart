import 'package:dummy_json_app/core/theme/app_theme.dart';
import 'package:dummy_json_app/src/config/router/router.dart';
import 'package:dummy_json_app/src/features/favorites/data/providers.dart';
import 'package:dummy_json_app/src/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MainApp(sharedPreferences: sharedPreferences));
}

class MainApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MainApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalization.localizationsDelegates,
        supportedLocales: const [
          Locale('en'),
        ],
        title: 'Dummy JSON App',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
