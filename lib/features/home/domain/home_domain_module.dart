import 'package:daily_news/features/home/data/home_data_module.dart';
import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final getArticlesUsecaseProvider = FutureProvider<GetArticlesUsecase>(
//   (ref) async {
//     final repository = await ref.watch(articlesRepositoryProvider.future);
//     return GetArticlesUsecase(repository);
//   },
// );
