import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should return a valid intance when initializing using the constructor',
    () async {
      // arrange
      final dateNow = DateTime.now();

      // act
      final articleEntity = ArticleEntity(
        title: 'title',
        description: 'description',
        imageUrl: 'imageUrl',
        author: '',
        publishedAt: dateNow,
        content: 'content',
      );

      // assert
      expect(articleEntity, isInstanceOf<ArticleEntity>());
    },
  );
}
