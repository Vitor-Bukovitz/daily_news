import 'package:daily_news/app.dart';
import 'package:daily_news/core/providers/data_providers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(defaultBoxName);
  runApp(const App());
}
