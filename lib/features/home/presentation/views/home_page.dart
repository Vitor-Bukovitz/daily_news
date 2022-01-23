import 'package:daily_news/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:daily_news/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DefaultTabController(
        length: ArticlesType.values.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return HomeSliverAppbar.withTabBar();
          },
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(color: Colors.red, height: 100),
              ),
              SliverToBoxAdapter(
                child: Container(color: Colors.amber, height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}