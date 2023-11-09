import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/repositories/package_info/package_info_repository.dart';
import 'core/repositories/shared_preferences/shared_preference_repository.dart';
import 'core/utils/flavor.dart';
import 'core/utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final PackageInfo packageInfo;
  late final SharedPreferences sharedPreferences;
  Logger.configure();

  await (
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]),
  Future(() async {
    packageInfo = await PackageInfo.fromPlatform();
  }),
  Future(() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }),
  ).wait;

  logger.info(Flavor.environment);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesRepositoryProvider
            .overrideWithValue(SharedPreferencesRepository(sharedPreferences)),
        packageInfoRepositoryProvider
            .overrideWithValue(PackageInfoRepository(packageInfo)),
      ],
      child: const App(),
    ),
  );
}