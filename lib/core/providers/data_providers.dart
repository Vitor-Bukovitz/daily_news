import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

final boxProvider = FutureProvider<Box>((_) async {
  await Hive.initFlutter();
  return Hive.openBox('daily_news');
});

final httpProvider = Provider<http.Client>((_) => http.Client());
