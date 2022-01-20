import 'dart:convert';

import 'package:daily_news/features/home/data/datasources/articles_local_data_source.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_local_data_source_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late final Box box;
  late final ArticlesLocalDataSource articlesLocalDataSource;

  setUpAll(() async {
    box = MockBox();
    articlesLocalDataSource = ArticlesLocalDataSourceImpl(box: box);
  });

  const defaultParameter = ArticlesType.general;

  group('cacheArticles', () {
    test(
      'should call box.put when caching articles',
      () async {
        // arrange
        final expected = [
          ArticleModel(
            title: '',
            description: '',
            imageUrl: '',
            publishedAt: DateTime.now(),
            content: '',
          ),
        ];
        articlesLocalDataSource.cacheArticles(expected, defaultParameter);

        // assert
        verify(
          box.put(
            '$cachedArticlesKey${defaultParameter.name}',
            json.encode(
              expected.map((e) => (e).toMap()).toList(),
            ),
          ),
        );
      },
    );
  });

  group('getCachedArticles', () {
    test(
      'should return a valid empty list of articles when calling getCachedArticles from the local data source',
      () async {
        // arrange
        final expected = <ArticleEntity>[];
        when(box.get(cachedArticlesKey))
            .thenAnswer((_) => json.encode(expected));

        // act
        final actual =
            await articlesLocalDataSource.getCachedArticles(defaultParameter);

        // assert
        verify(box.get(cachedArticlesKey)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with a single article when calling getCachedArticles from the data source',
      () async {
        // arrange
        final expected = [
          ArticleModel(
            title: '',
            description: '',
            imageUrl: '',
            publishedAt: DateTime.now(),
            content: '',
          ),
        ];
        when(box.get(cachedArticlesKey)).thenAnswer(
          (_) => json.encode(
            expected.map((e) => e.toMap()).toList(),
          ),
        );

        // act
        final actual =
            await articlesLocalDataSource.getCachedArticles(defaultParameter);

        // assert
        verify(box.get(cachedArticlesKey)).called(1);
        expect(actual, expected);
      },
    );

    test(
      'should return a valid list of articles with two articles when calling getCachedArticles from the data source',
      () async {
        // arrange
        final article = ArticleModel(
          title: '',
          description: '',
          imageUrl: '',
          publishedAt: DateTime.now(),
          content: '',
        );
        final expected = [article, article];
        when(box.get(cachedArticlesKey)).thenAnswer(
          (_) => json.encode(
            expected.map((e) => e.toMap()).toList(),
          ),
        );

        // act
        final actual =
            await articlesLocalDataSource.getCachedArticles(defaultParameter);

        // assert
        verify(box.get(cachedArticlesKey)).called(1);
        expect(actual, expected);
      },
    );
  });
}
