import 'package:daily_news/core/providers/config_providers.dart';
import 'package:daily_news/core/providers/data_providers.dart';
import 'package:daily_news/features/home/data/datasources/articles_local_data_source.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/data/repositories/articles_repository_impl.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articlesLocalDataSourceProvider = Provider<ArticlesLocalDataSource>(
  (ref) {
    final box = ref.watch(boxProvider);
    return ArticlesLocalDataSourceImpl(
      box: box,
    );
  },
);

final articlesRemoteDataSourceProvider =
    Provider<ArticlesRemoteDataSource>((ref) {
  final client = ref.watch(httpProvider);
  final config = ref.watch(environmentConfigProvider);
  return ArticlesRemoteDataSourceImpl(
    client: client,
    config: config,
  );
});

final articlesRepositoryProvider = Provider<ArticlesRepository>(
  (ref) {
    final remoteDataSource = ref.watch(articlesRemoteDataSourceProvider);
    final localDataSource = ref.watch(articlesLocalDataSourceProvider);
    return ArticlesRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  },
);
