import 'package:daily_news/features/home/domain/entities/article_entity.dart';
import 'package:daily_news/features/home/domain/home_domain_module.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeArticlesProvider = FutureProvider.autoDispose
    .family<List<ArticleEntity>, ArticlesType>((ref, articleType) async {
  final getArticlesUsecase = ref.watch(getArticlesUsecaseProvider);
  final result = await getArticlesUsecase.call(articleType);
  return result.fold((l) => throw l, (r) => r);
});
