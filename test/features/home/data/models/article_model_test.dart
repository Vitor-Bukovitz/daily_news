import 'dart:convert';
import 'dart:io';

import 'package:daily_news/features/home/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should return a valid ArticleEntity when converting from a valid json',
    () async {
      // arrange
      final file = File('test/resources/article.json');
      final map = jsonDecode(await file.readAsString());

      // act
      final entity = ArticleModel.fromMap(map);

      // assert
      expect(entity, isInstanceOf<ArticleModel>());
    },
  );
  test(
    'should throw a FormatException when converting from an invalid json',
    () async {
      // arrange
      final file = File('test/resources/articles.json');
      final map = jsonDecode(await file.readAsString());

      // act
      const articleConverter = ArticleModel.fromMap;

      // assert
      expect(
        () => articleConverter(map),
        throwsA(
          isInstanceOf<FormatException>(),
        ),
      );
    },
  );
}
