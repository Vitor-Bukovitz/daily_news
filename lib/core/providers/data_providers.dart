import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

const defaultBoxName = 'daily_news';
final boxProvider = Provider<Box>((_) => Hive.box(defaultBoxName));

final httpProvider = Provider<http.Client>((_) => http.Client());
