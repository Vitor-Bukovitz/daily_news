import 'package:daily_news/core/error/exceptions.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/features/home/data/datasources/articles_local_data_source.dart';
import 'package:daily_news/features/home/data/datasources/articles_remote_data_source.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRemoteDataSource remoteDataSource;
  ArticlesLocalDataSource localDataSource;
  ArticlesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, DateTime>> getLastArticlesDateTime(
      ArticlesType articlesType) async {
    try {
      final dateTime = await localDataSource.getLastArticlesDateTime(
        articlesType,
      );
      return Right(dateTime);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getCachedArticles(
    ArticlesType articlesType,
  ) async {
    try {
      final articles = await localDataSource.getCachedArticles(articlesType);
      return Right(articles);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getRemoteArticles(
    ArticlesType articlesType,
  ) async {
    try {
      final articlesList = await remoteDataSource.getArticles(articlesType);
      localDataSource.cacheArticles(articlesList);
      return Right(articlesList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
