import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:daily_news/features/home/presentation/widgets/home_tabbar_indicator.dart';
import 'package:daily_news/features/home/presentation/widgets/home_tabbar_sliver_header.dart';
import 'package:daily_news/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class HomeSliverTabBar extends StatelessWidget {
  const HomeSliverTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HomeTabBarSliverHeader(
        tabBar: TabBar(
          isScrollable: true,
          indicator: HomeTabIndicator(
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
          tabs: ArticlesType.values.map(
            (articleType) {
              return Tab(
                text: articleType.name.capitalize(),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
