import 'dart:convert';

import 'package:daily_news/core/error/exceptions.dart';
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
        CustomizableDateTime.current = DateTime.now();
        final expected = [
          ArticleModel(
            title: '',
            description: '',
            imageUrl: '',
            publishedAt: DateTime.now(),
            content: '',
          ),
        ];

        // act
        await articlesLocalDataSource.cacheArticles(expected, defaultParameter);

        // assert
        verify(
          box.put(
            '$cachedArticlesKey${defaultParameter.name}',
            json.encode(
              expected.map((e) => (e).toMap()).toList(),
            ),
          ),
        ).called(1);
        verify(
          box.put(
            '$lastArticlesDateTimeKey${defaultParameter.name}',
            CustomizableDateTime.current,
          ),
        ).called(1);
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

  group('getLastArticlesDateTime', () {
    test(
      'should return the current time when calling getLastArticlesDateTime',
      () async {
        // arrange
        CustomizableDateTime.current = DateTime.now();
        when(
          box.get('$lastArticlesDateTimeKey${defaultParameter.name}'),
        ).thenAnswer((_) => CustomizableDateTime.current);

        // act
        final actual = await articlesLocalDataSource
            .getLastArticlesDateTime(defaultParameter);

        // assert
        expect(actual, CustomizableDateTime.current);
        verify(box.get('$lastArticlesDateTimeKey${defaultParameter.name}'))
            .called(1);
      },
    );

    test(
      'should throw a [CacheException] when calling getLastArticlesDateTime',
      () async {
        // arrange
        CustomizableDateTime.current = DateTime.now();
        when(
          box.get('$lastArticlesDateTimeKey${defaultParameter.name}'),
        ).thenAnswer((_) => null);

        // act
        final actual = articlesLocalDataSource.getLastArticlesDateTime;

        // assert
        expect(
          () => actual(defaultParameter),
          throwsA(
            isInstanceOf<CacheException>(),
          ),
        );
      },
    );
  });
}
