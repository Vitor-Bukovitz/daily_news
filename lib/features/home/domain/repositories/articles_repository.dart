import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles(
    ArticlesType articlesType,
  );
}
