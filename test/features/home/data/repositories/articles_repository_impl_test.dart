import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/data/datasources/articles_local_data_source.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/data/repositories/articles_repository_impl.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_repository_impl_test.mocks.dart';

@GenerateMocks([ArticlesRemoteDataSource, ArticlesLocalDataSource])
void main() {
  late final ArticlesRepository repository;
  late final ArticlesRemoteDataSource remoteDataSource;
  late final ArticlesLocalDataSource localDataSource;

  setUpAll(() {
    remoteDataSource = MockArticlesRemoteDataSource();
    localDataSource = MockArticlesLocalDataSource();
    repository = ArticlesRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  const defaultParameter = ArticlesType.general;

  group('getRemoteArticles', () {
    test(
      'should return a valid empty list of articles when calling getArticles from the repository',
      () async {
        // arrange
        final emptyArray = <ArticleModel>[];
        final expected = Right<Failure, List<ArticleEntity>>(emptyArray);
        when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
          (_) async => emptyArray,
        );

        // act
        final actual = await repository.getRemoteArticles(defaultParameter);

        // assert
        verify(remoteDataSource.getArticles(defaultParameter)).called(1);
        verify(localDataSource.cacheArticles(emptyArray, defaultParameter))
            .called(1);
        verifyNever(localDataSource.getCachedArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with a single article when calling getArticles from the repository',
      () async {
        // arrange
        final listSingleArticle = [
          ArticleModel(
            title: '',
            description: '',
            imageUrl: '',
            author: '',
            publishedAt: DateTime.now(),
            content: '',
          ),
        ];
        final expected = Right<Failure, List<ArticleEntity>>(listSingleArticle);
        when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
          (_) async => listSingleArticle,
        );

        // act
        final actual = await repository.getRemoteArticles(defaultParameter);

        // assert
        verify(remoteDataSource.getArticles(defaultParameter)).called(1);
        verify(localDataSource.cacheArticles(
                listSingleArticle, defaultParameter))
            .called(1);
        verifyNever(localDataSource.getCachedArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with two articles when calling getArticles from the repository',
      () async {
        // arrange
        final article = ArticleModel(
          title: '',
          description: '',
          imageUrl: '',
          author: '',
          publishedAt: DateTime.now(),
          content: '',
        );
        final listTwoArticles = [article, article];
        final expected = Right<Failure, List<ArticleEntity>>(listTwoArticles);
        when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
          (_) async => listTwoArticles,
        );

        // act
        final actual = await repository.getRemoteArticles(defaultParameter);

        // assert
        verify(remoteDataSource.getArticles(defaultParameter)).called(1);
        verify(localDataSource.cacheArticles(listTwoArticles, defaultParameter))
            .called(1);
        verifyNever(localDataSource.getCachedArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a [ServerFailue] when calling getArticles from the repository',
      () async {
        // arrange
        final failure = ServerFailure();
        final expected = Left<Failure, List<ArticleEntity>>(failure);
        when(remoteDataSource.getArticles(defaultParameter)).thenAnswer(
          (_) async => throw ServerException(),
        );

        // act
        final actual = await repository.getRemoteArticles(defaultParameter);

        // assert
        verify(remoteDataSource.getArticles(defaultParameter)).called(1);
        verifyNever(localDataSource.cacheArticles([], defaultParameter));
        verifyNever(localDataSource.getCachedArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );
  });

  group('getLastArticlesDateTime', () {
    test(
      'should return current date time from local data source when calling repository getLastArticlesDateTime',
      () async {
        // arrange
        final expected = DateTime.now();
        when(localDataSource.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual =
            await repository.getLastArticlesDateTime(defaultParameter);

        // assert
        verify(localDataSource.getLastArticlesDateTime(defaultParameter))
            .called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, Right(expected));
      },
    );

    test(
      'should return CacheFailure when the localDataSource throws CacheException',
      () async {
        // arrange
        final expected = Left<Failure, DateTime>(CacheFailure());
        when(localDataSource.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => throw CacheException());

        // act
        final actual =
            await repository.getLastArticlesDateTime(defaultParameter);

        // assert
        verify(localDataSource.getLastArticlesDateTime(defaultParameter))
            .called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );
  });

  group('getCachedArticles', () {
    test(
      'should return a valid empty list of articles when calling getCachedArticles from the repository',
      () async {
        // arrange
        final emptyArray = <ArticleEntity>[];
        final expected = Right<Failure, List<ArticleEntity>>(emptyArray);
        when(localDataSource.getCachedArticles(defaultParameter)).thenAnswer(
          (_) async => emptyArray,
        );

        // act
        final actual = await repository.getCachedArticles(defaultParameter);

        // assert
        verify(localDataSource.getCachedArticles(defaultParameter)).called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with a single article when calling getCachedArticles from the repository',
      () async {
        // arrange
        final listSingleArticle = [
          ArticleEntity(
            title: '',
            description: '',
            imageUrl: '',
            author: '',
            publishedAt: DateTime.now(),
            content: '',
          ),
        ];
        final expected = Right<Failure, List<ArticleEntity>>(listSingleArticle);
        when(localDataSource.getCachedArticles(defaultParameter)).thenAnswer(
          (_) async => listSingleArticle,
        );

        // act
        final actual = await repository.getCachedArticles(defaultParameter);

        // assert
        verify(localDataSource.getCachedArticles(defaultParameter)).called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with two articles when calling getCachedArticles from the repository',
      () async {
        // arrange
        final article = ArticleEntity(
          title: '',
          description: '',
          imageUrl: '',
          author: '',
          publishedAt: DateTime.now(),
          content: '',
        );
        final listTwoArticles = [article, article];
        final expected = Right<Failure, List<ArticleEntity>>(listTwoArticles);
        when(localDataSource.getCachedArticles(defaultParameter)).thenAnswer(
          (_) async => listTwoArticles,
        );

        // act
        final actual = await repository.getCachedArticles(defaultParameter);

        // assert
        verify(localDataSource.getCachedArticles(defaultParameter)).called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );

    test(
      'should return a [CacheFailure] when calling getCachedArticles from the repository',
      () async {
        // arrange
        final failure = CacheFailure();
        final expected = Left<Failure, List<ArticleEntity>>(failure);
        when(localDataSource.getCachedArticles(defaultParameter)).thenAnswer(
          (_) async => throw CacheException(),
        );

        // act
        final actual = await repository.getCachedArticles(defaultParameter);

        // assert
        verify(localDataSource.getCachedArticles(defaultParameter)).called(1);
        verifyNever(remoteDataSource.getArticles(defaultParameter));
        verifyNever(localDataSource.getLastArticlesDateTime(defaultParameter));
        expect(actual, expected);
      },
    );
  });
}
