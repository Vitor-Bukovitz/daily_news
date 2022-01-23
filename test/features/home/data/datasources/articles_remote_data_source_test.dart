import 'dart:convert';
import 'dart:io';

import 'package:daily_news/core/error/exceptions.dart';
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
    when(config.baseApiUrl).thenReturn('url.com');
    when(config.newsApiKey).thenReturn('123');
  });

  tearDown(() {
    verify(config.baseApiUrl).called(1);
    verify(config.newsApiKey).called(1);
  });

  const defaultParameter = ArticlesType.business;

  group('getArticles', () {
    test(
      'should call the API with no category header when the article type is trending',
      () async {
        // arrange
        final file = File('test/resources/articles.json');
        final responseString = await file.readAsString();
        final expected = ((json.decode(responseString)
                as Map<String, dynamic>)['articles'] as List<dynamic>)
            .map((e) => ArticleModel.fromMap(e))
            .toList();
        when(httpClient.get(
          Uri.parse('https://url.com/v2/top-headlines?apiKey=123&country=us'),
        )).thenAnswer(
          (_) async => http.Response(responseString, 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }),
        );

        // act
        final actual =
            await remoteDataSource.getArticles(ArticlesType.trending);

        // assert
        expect(actual, expected);
        verify(httpClient.get(
          Uri.parse('https://url.com/v2/top-headlines?apiKey=123&country=us'),
        )).called(1);
      },
    );

    test(
      'should return an array of articles according to the resource in local files when calling the remote data source',
      () async {
        // arrange
        final file = File('test/resources/articles.json');
        final responseString = await file.readAsString();
        final expected = ((json.decode(responseString)
                as Map<String, dynamic>)['articles'] as List<dynamic>)
            .map((e) => ArticleModel.fromMap(e))
            .toList();
        when(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).thenAnswer(
          (_) async => http.Response(responseString, 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }),
        );

        // act
        final actual = await remoteDataSource.getArticles(defaultParameter);

        // assert
        expect(actual, expected);
        verify(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).called(1);
      },
    );

    test(
      'should throw a ServerException when something goes wrong with the request and it throws an exeption',
      () async {
        // arrange
        when(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).thenAnswer(
            (_) => throw http.ClientException('Something went wrong'));

        // act
        final actual = remoteDataSource.getArticles;

        // assert
        expect(
          () => actual(defaultParameter),
          throwsA(
            isInstanceOf<ServerException>(),
          ),
        );
        verify(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).called(1);
      },
    );

    test(
      'should throw a ServerException when the response status code is not 200',
      () async {
        // arrange
        when(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).thenAnswer((_) async => http.Response('', 404));

        // act
        final actual = remoteDataSource.getArticles;

        // assert
        expect(
          () => actual(defaultParameter),
          throwsA(
            isInstanceOf<ServerException>(),
          ),
        );
        verify(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).called(1);
      },
    );

    test(
      'should throw a ServerException when the status code is 200 but the json is invalid',
      () async {
        // arrange
        when(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).thenAnswer(
          (_) async => http.Response('{articles:[{\'dsad\': dsoajdosa}]}', 200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }),
        );

        // act
        final actual = remoteDataSource.getArticles;

        // assert
        expect(
          () => actual(defaultParameter),
          throwsA(
            isInstanceOf<ServerException>(),
          ),
        );
        verify(httpClient.get(
          Uri.parse(
              'https://url.com/v2/top-headlines?apiKey=123&country=us&category=business'),
        )).called(1);
      },
    );
  });
}
