import 'package:flutter/material.dart';

class HomeTabBarSliverHeader extends SliverPersistentHeaderDelegate {
  const HomeTabBarSliverHeader({
    required this.tabBar,
  });
  final TabBar tabBar;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      height: tabBar.preferredSize.height,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return tabBar != (oldDelegate as HomeTabBarSliverHeader).tabBar;
  }
}
