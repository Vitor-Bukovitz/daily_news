import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:daily_news/features/home/presentation/widgets/home_tabbar_indicator.dart';
import 'package:daily_news/features/home/presentation/widgets/home_tabbar_sliver_header.dart';
import 'package:flutter/material.dart';

class HomeSliverTabBar extends StatelessWidget {
  const HomeSliverTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: HomeTabBarSliverHeader(
          tabBar: TabBar(
            isScrollable: true,
            indicator: HomeTabIndicator(
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
            tabs: ArticlesType.values.map(
              (e) {
                return Tab(
                  text: e.index == 0 ? 'For you' : 'Largest label in the world',
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
