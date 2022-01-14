import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRemoteDataSource remoteDataSource;
  ArticlesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles(
    ArticlesType articlesType,
  ) async {
    try {
      final articlesList = await remoteDataSource.getArticles(articlesType);
      return Right(articlesList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
