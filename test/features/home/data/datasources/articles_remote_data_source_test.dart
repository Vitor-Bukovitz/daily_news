import 'dart:convert';

import 'package:daily_news/core/providers/config_providers.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'articles_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client, EnvironmentConfig])
void main() {
  late final http.Client httpClient;
  late final EnvironmentConfig config;
  late final ArticlesRemoteDataSource remoteDataSource;

  setUpAll(() {
    httpClient = MockClient();
    config = MockEnvironmentConfig();
    remoteDataSource = ArticlesRemoteDataSourceImpl(
      client: httpClient,
      config: config,
    );
  });

  setUp(() async {
    when(config.baseApiUrl).thenReturn('https://www.url.com/');
    when(config.newsApiKey).thenReturn('123');
  });

  tearDown(() {
    verify(config.baseApiUrl).called(1);
    verify(config.newsApiKey).called(1);
    verify(httpClient.get(
      Uri.parse(
          'https://www.url.com/top-headlines?category=business&apiKey=123'),
    )).called(1);
  });

  const defaultParameter = ArticlesType.business;

  group('getArticles', () {
    test(
      'should return an empty array of articles from the remote data source when calling getArticles',
      () async {
        // arrange
        final expected = [
          ArticleModel(
            title: 'title',
            description: 'description',
            imageUrl: 'imageUrl',
            publishedAt: DateTime.now(),
            content: 'content',
          ),
        ];
        when(httpClient.get(
          Uri.parse(
              'https://www.url.com/top-headlines?category=business&apiKey=123'),
        )).thenAnswer(
          (_) async => http.Response(
              json.encode(expected.map((e) => e.toMap()).toList()), 200),
        );

        // act
        final actual = remoteDataSource.getArticles(defaultParameter);

        // assert
        expect(actual, expected);
      },
    );
  });
}
