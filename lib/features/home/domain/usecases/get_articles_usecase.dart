import 'package:daily_news/core/usecases/either.dart';
import 'package:daily_news/core/error/failure.dart';
import 'package:daily_news/core/usecases/usecase.dart';
import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/repositories/articles_repository.dart';

class GetArticlesUsecase extends Usecase<List<ArticleEntity>, NoParams> {
  final ArticlesRepository _repository;
  GetArticlesUsecase(this._repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return _repository.getArticles();
  }
}
