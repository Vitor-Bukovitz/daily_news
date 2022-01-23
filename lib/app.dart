import 'package:daily_news/core/providers/theme_mode_provider.dart';
import 'package:daily_news/core/theme/theme_data.dart';
import 'package:daily_news/features/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final themeMode = ref.watch(themeModeProvider);
          return MaterialApp(
            title: 'Daily News',
            home: const HomePage(),
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
