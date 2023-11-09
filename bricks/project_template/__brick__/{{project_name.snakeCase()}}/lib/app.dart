import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/res/theme.dart';
import 'core/utils/navigator_key_provider.dart';
import 'core/widgets/have_scroll_bar_behavior.dart';
import 'features/start_up/pages/start_up_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);
    return MaterialApp(
      title: 'TODO',
      navigatorKey: navigatorKey,
      scrollBehavior: const HaveScrollBarBehavior(),
      theme: getAppTheme(),
      darkTheme: getAppThemeDark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const StartUpPage(),
    );
  }
}
