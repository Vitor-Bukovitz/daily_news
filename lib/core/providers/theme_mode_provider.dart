import 'package:daily_news/core/providers/data_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const themeModeKey = 'themeModeKey';

final themeModeProvider = Provider<ThemeMode>((ref) {
  final box = ref.watch(boxProvider);
  final cachedThemeMode = box.get(themeModeKey);
  if (cachedThemeMode is int) {
    return ThemeMode.values.firstWhere(
      (element) => element.index == cachedThemeMode,
      orElse: () => ThemeMode.system,
    );
  } else {
    return ThemeMode.system;
  }
});
