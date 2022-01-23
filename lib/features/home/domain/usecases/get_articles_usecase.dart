import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/usecase.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';

class GetArticlesUsecase extends Usecase<List<ArticleEntity>, ArticlesType> {
  final ArticlesRepository _repository;
  GetArticlesUsecase(this._repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(ArticlesType params) async {
    final articlesDateTime = await _repository.getLastArticlesDateTime(params);
    return articlesDateTime.fold((l) {
      return _repository.getRemoteArticles(params);
    }, (lastTime) {
      final timeNow = DateTime.now();
      final dateTimeDifferenceInHours = timeNow.difference(lastTime).inDays;
      if (dateTimeDifferenceInHours >= 1) {
        return _repository.getRemoteArticles(params);
      } else {
        return _repository.getCachedArticles(params);
      }
    });
  }
}

enum ArticlesType {
  trending,
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology
}
