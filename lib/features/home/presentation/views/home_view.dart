import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:daily_news/features/home/presentation/providers/home_articles_provider.dart';
import 'package:daily_news/features/home/presentation/widgets/home_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.articleType,
  }) : super(key: key);
  final ArticlesType articleType;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final articles = ref.watch(homeArticlesProvider(articleType));
        return articles.when(
          data: (articles) {
            return RefreshIndicator(
              onRefresh: () async =>
                  ref.refresh(homeArticlesProvider(articleType)),
              child: ListView.builder(
                padding: const EdgeInsetsDirectional.only(top: 24),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return HomeListCard(article: article);
                },
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Please verify your network connection and try again later.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
