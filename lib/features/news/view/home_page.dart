import 'package:appcent_news_task/core/components/my_custom_bottom_navi.dart';
import 'package:appcent_news_task/core/components/tab_items.dart';
import 'package:appcent_news_task/features/news/view/favorites_view.dart';
import 'package:appcent_news_task/features/news/view/news_view.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.news;
  Map<TabItem, Widget> allPages() {
    return {
      // burada viewModel'ı verebilirsin ChangeNotifierProvider ile
      TabItem.news: const NewsView(),
      TabItem.favorites: const FavoritesView(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomBottomNavigation(
          pageBuilder: allPages(),
          currentTab: _currentTab,
          onSelectedTab: (onSelectedTab) {
            _currentTab = onSelectedTab;

            onSelectedTab == TabItem.news
                ? const NewsView()
                : const FavoritesView();
          }),
    );
  }
}
