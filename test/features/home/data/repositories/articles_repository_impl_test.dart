import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/data/repositories/articles_repository_impl.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_repository_impl_test.mocks.dart';

@GenerateMocks([ArticlesRemoteDataSource])
void main() {
  late final ArticlesRepository repository;
  late final ArticlesRemoteDataSource remoteDataSource;

  setUpAll(() {
    remoteDataSource = MockArticlesRemoteDataSource();
    repository = ArticlesRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
  });

  const defaultParameter = ArticlesType.general;

  test(
    'should return a valid empty list of articles when calling getArticles from the repository',
    () async {
      // arrange
      final emptyArray = <ArticleEntity>[];
      final expected = Right<Failure, List<ArticleEntity>>(emptyArray);
      when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
        (_) async => emptyArray,
      );

      // act
      final actual = await repository.getArticles(defaultParameter);

      // assert
      verify(remoteDataSource.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );

  test(
    'should throw a [ServerException] when calling getArticles from the repository',
    () async {
      // arrange
      final failure = ServerFailure();
      final expected = Left<Failure, List<ArticleEntity>>(failure);
      when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
        (_) async => throw ServerException(),
      );

      // act
      final actual = await repository.getArticles(defaultParameter);

      // assert
      verify(remoteDataSource.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );
}
