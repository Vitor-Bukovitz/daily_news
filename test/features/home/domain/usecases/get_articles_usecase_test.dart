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

  test(
    'should return an empty list of articles from the repository when calling the usecase',
    () async {
      // arrange
      final expected = Right<Failure, List<ArticleEntity>>([]);
      when(repository.getArticles(defaultParameter))
          .thenAnswer((_) async => expected);

      // act
      final actual = await usecase(defaultParameter);

      // assert
      verify(repository.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );

  test(
    'should return a list with a single article from the repository when calling the usecase',
    () async {
      // arrange
      final expected = Right<Failure, List<ArticleEntity>>([
        ArticleEntity(
          title: "",
          description: "",
          imageUrl: "",
          publishedAt: DateTime.now(),
          content: "",
        )
      ]);
      when(repository.getArticles(defaultParameter))
          .thenAnswer((_) async => expected);

      // act
      final actual = await usecase(defaultParameter);

      // assert
      verify(repository.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );

  test(
    'should return a list with two articles from the repository when calling the usecase',
    () async {
      // arrange
      final entity = ArticleEntity(
        title: "",
        description: "",
        imageUrl: "",
        publishedAt: DateTime.now(),
        content: "",
      );
      final expected = Right<Failure, List<ArticleEntity>>([entity, entity]);
      when(repository.getArticles(defaultParameter))
          .thenAnswer((_) async => expected);

      // act
      final actual = await usecase(defaultParameter);

      // assert
      verify(repository.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );

  test(
    'should return a [ServerFailure] from the repository when calling the usecase',
    () async {
      // arrange
      final expected = Left<Failure, List<ArticleEntity>>(ServerFailure());
      when(repository.getArticles(defaultParameter))
          .thenAnswer((_) async => expected);

      // act
      final actual = await usecase(defaultParameter);

      // assert
      verify(repository.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );

  test(
    'should return a [ParseFailure] from the repository when calling the usecase',
    () async {
      // arrange
      final expected = Left<Failure, List<ArticleEntity>>(ParseFailure());
      when(repository.getArticles(defaultParameter))
          .thenAnswer((_) async => expected);

      // act
      final actual = await usecase(defaultParameter);

      // assert
      verify(repository.getArticles(defaultParameter)).called(1);
      expect(actual, expected);
    },
  );
}
