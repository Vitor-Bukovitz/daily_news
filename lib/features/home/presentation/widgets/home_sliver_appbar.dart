import 'package:daily_news/features/home/presentation/widgets/home_sliver_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSliverAppbar extends StatelessWidget {
  const HomeSliverAppbar({
    Key? key,
  }) : super(key: key);

  static List<Widget> withTabBar() {
    return const [
      HomeSliverAppbar(),
      HomeSliverTabBar(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 144,
      elevation: 0,
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(
          'assets/icons/menuIcon.svg',
          color: Theme.of(context).iconTheme.color,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            end: 16,
          ),
          child: SvgPicture.asset(
            'assets/icons/searchIcon.svg',
            color: Theme.of(context).iconTheme.color,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            titlePadding: EdgeInsetsDirectional.only(
              start: _startPaddingValue(constraints: constraints),
              bottom: 16,
            ),
            title: Text(
              'Daily News',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          );
        },
      ),
    );
  }

  double _startPaddingValue({
    required BoxConstraints constraints,
  }) {
    const oldMax = 178;
    const oldMin = 90;
    const oldRange = oldMax - oldMin;

    const newMin = 56;
    const newMax = 16;
    const newRange = newMax - newMin;

    final oldValue = constraints.maxHeight;
    final newValue = (((oldValue - oldMin) * newRange) / oldRange) + newMin;
    return newValue;
  }
}
