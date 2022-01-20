// Mocks generated by Mockito 5.0.17 from annotations
// in daily_news/test/features/home/data/repositories/articles_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:daily_news/features/home/data/datasources/articles_local_data_source.dart'
    as _i6;
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart'
    as _i2;
import 'package:daily_news/features/home/data/models/article_model.dart' as _i4;
import 'package:daily_news/features/home/domain/entities/article_entity.dart'
    as _i7;
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDateTime_0 extends _i1.Fake implements DateTime {}

/// A class which mocks [ArticlesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockArticlesRemoteDataSource extends _i1.Mock
    implements _i2.ArticlesRemoteDataSource {
  MockArticlesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.ArticleModel>> getArticles(
          _i5.ArticlesType? articlesType) =>
      (super.noSuchMethod(Invocation.method(#getArticles, [articlesType]),
              returnValue:
                  Future<List<_i4.ArticleModel>>.value(<_i4.ArticleModel>[]))
          as _i3.Future<List<_i4.ArticleModel>>);
}

/// A class which mocks [ArticlesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockArticlesLocalDataSource extends _i1.Mock
    implements _i6.ArticlesLocalDataSource {
  MockArticlesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i7.ArticleEntity>> getCachedArticles(
          _i5.ArticlesType? articlesType) =>
      (super.noSuchMethod(Invocation.method(#getCachedArticles, [articlesType]),
              returnValue:
                  Future<List<_i7.ArticleEntity>>.value(<_i7.ArticleEntity>[]))
          as _i3.Future<List<_i7.ArticleEntity>>);
  @override
  _i3.Future<DateTime> getLastArticlesDateTime(
          _i5.ArticlesType? articlesType) =>
      (super.noSuchMethod(
              Invocation.method(#getLastArticlesDateTime, [articlesType]),
              returnValue: Future<DateTime>.value(_FakeDateTime_0()))
          as _i3.Future<DateTime>);
  @override
  _i3.Future<void> cacheArticles(
          List<_i4.ArticleModel>? articles, _i5.ArticlesType? articlesType) =>
      (super.noSuchMethod(
          Invocation.method(#cacheArticles, [articles, articlesType]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
