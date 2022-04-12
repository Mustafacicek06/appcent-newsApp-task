import 'package:appcent_news_task/components/my_custom_bottom_navi.dart';
import 'package:appcent_news_task/components/tab_items.dart';
import 'package:appcent_news_task/model/news_model.dart';
import 'package:appcent_news_task/view/favorites_view.dart';
import 'package:appcent_news_task/view/news_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.news;
  Map<TabItem, Widget> allPages() {
    return {
      // burada viewModel'ı verebilirsin ChangeNotifierProvider ile
      TabItem.news: NewsView(),
      TabItem.favorites: FavoritesView(),
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

            onSelectedTab == TabItem.news ? NewsView() : FavoritesView();
          }),
    );
  }
}
