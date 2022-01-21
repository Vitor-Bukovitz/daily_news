import 'package:flutter_riverpod/flutter_riverpod.dart';

/// To setup any enviroment configuration, add by running like the following: 'flutter run --dart-define=newsApiKey={MYKEY}`
abstract class EnvironmentConfig {
  String get newsApiKey => const String.fromEnvironment('newsApiKey');
  String get baseApiUrl => const String.fromEnvironment('baseApiUrl');
}

class EnvironmentConfigImpl extends EnvironmentConfig {}

final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfigImpl();
});
