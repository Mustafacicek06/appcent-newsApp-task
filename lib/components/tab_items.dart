import 'package:flutter/material.dart';

enum TabItem { news, favorites }

class TabItemData {
  final String label;
  final IconData icon;

  TabItemData(this.label, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.news: TabItemData("News", Icons.newspaper_outlined),
    TabItem.favorites: TabItemData(
      "Favorites",
      Icons.favorite,
    )
  };
}
