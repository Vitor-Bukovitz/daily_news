import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_articles_usecase_test.mocks.dart';

@GenerateMocks([ArticlesRepository])
void main() {
  late final GetArticlesUsecase usecase;
  late final MockArticlesRepository repository;

  setUpAll(() {
    repository = MockArticlesRepository();
    usecase = GetArticlesUsecase(repository);
  });

  const defaultParameter = ArticlesType.general;

  group('testing with datetime > 24 hours', () {
    test(
      'should return an empty list of articles from the repository when is one day after cache',
      () async {
        // arrange
        final oneDayAgoDateTime = Right<Failure, DateTime>(
            DateTime.now().subtract(const Duration(days: 1)));
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => oneDayAgoDateTime);
        final expected = Right<Failure, List<ArticleEntity>>([]);
        when(repository.getRemoteArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getRemoteArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a list with a single article from the repository when calling the usecase',
      () async {
        // arrange
        final oneDayAgoDateTime = Right<Failure, DateTime>(
            DateTime.now().subtract(const Duration(days: 1)));
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => oneDayAgoDateTime);
        final expected = Right<Failure, List<ArticleEntity>>([
          ArticleEntity(
            title: '',
            description: '',
            imageUrl: '',
            publishedAt: DateTime.now(),
            content: '',
          )
        ]);
        when(repository.getRemoteArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getRemoteArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a list with two articles from the repository when calling the usecase',
      () async {
        // arrange
        final oneDayAgoDateTime = Right<Failure, DateTime>(
            DateTime.now().subtract(const Duration(days: 1)));
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => oneDayAgoDateTime);
        final entity = ArticleEntity(
          title: '',
          description: '',
          imageUrl: '',
          publishedAt: DateTime.now(),
          content: '',
        );
        final expected = Right<Failure, List<ArticleEntity>>([entity, entity]);
        when(repository.getRemoteArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getRemoteArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a [ServerFailure] from the repository when calling the usecase',
      () async {
        // arrange
        final oneDayAgoDateTime = Right<Failure, DateTime>(
            DateTime.now().subtract(const Duration(days: 1)));
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => oneDayAgoDateTime);
        final expected = Left<Failure, List<ArticleEntity>>(ServerFailure());
        when(repository.getRemoteArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getRemoteArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a [ParseFailure] from the repository when calling the usecase',
      () async {
        // arrange
        final oneDayAgoDateTime = Right<Failure, DateTime>(
            DateTime.now().subtract(const Duration(days: 1)));
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => oneDayAgoDateTime);
        final expected = Left<Failure, List<ArticleEntity>>(ParseFailure());
        when(repository.getRemoteArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getRemoteArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );
  });
  group('testing with datetime < 24 hours', () {
    test(
      'should return an empty list of articles from the repository when is one day after cache',
      () async {
        // arrange
        final nowDateTime = Right<Failure, DateTime>(DateTime.now());
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => nowDateTime);
        final expected = Right<Failure, List<ArticleEntity>>([]);
        when(repository.getCachedArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getCachedArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a list with a single article from the repository when calling the usecase',
      () async {
        // arrange
        final nowDateTime = Right<Failure, DateTime>(DateTime.now());
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => nowDateTime);
        final expected = Right<Failure, List<ArticleEntity>>([
          ArticleEntity(
            title: '',
            description: '',
            imageUrl: '',
            publishedAt: DateTime.now(),
            content: '',
          )
        ]);
        when(repository.getCachedArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getCachedArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a list with two articles from the repository when calling the usecase',
      () async {
        // arrange
        final nowDateTime = Right<Failure, DateTime>(DateTime.now());
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => nowDateTime);
        final entity = ArticleEntity(
          title: '',
          description: '',
          imageUrl: '',
          publishedAt: DateTime.now(),
          content: '',
        );
        final expected = Right<Failure, List<ArticleEntity>>([entity, entity]);
        when(repository.getCachedArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getCachedArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a [CacheFailure] from the repository when calling the usecase',
      () async {
        // arrange
        final nowDateTime = Right<Failure, DateTime>(DateTime.now());
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => nowDateTime);
        final expected = Left<Failure, List<ArticleEntity>>(CacheFailure());
        when(repository.getCachedArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getCachedArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a [ParseFailure] from the repository when calling the usecase',
      () async {
        // arrange
        final nowDateTime = Right<Failure, DateTime>(DateTime.now());
        when(repository.getLastArticlesDateTime(defaultParameter))
            .thenAnswer((_) async => nowDateTime);
        final expected = Left<Failure, List<ArticleEntity>>(ParseFailure());
        when(repository.getCachedArticles(defaultParameter))
            .thenAnswer((_) async => expected);

        // act
        final actual = await usecase(defaultParameter);

        // assert
        verify(repository.getCachedArticles(defaultParameter)).called(1);
        expect(actual, expected);
      },
    );
  });
}
