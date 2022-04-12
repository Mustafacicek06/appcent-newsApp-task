import 'package:appcent_news_task/components/tab_items.dart';
import 'package:flutter/cupertino.dart';

class MyCustomBottomNavigation extends StatelessWidget {
  const MyCustomBottomNavigation(
      {Key? key,
      required this.currentTab,
      required this.onSelectedTab,
      required this.pageBuilder})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pageBuilder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _bottomNavigationBarItemCreate(TabItem.news),
          _bottomNavigationBarItemCreate(TabItem.favorites),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => Container(
            child: pageBuilder[TabItem.values[index]],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItemCreate(
      TabItem onSelectedItem) {
    final toBeCreatedTab = TabItemData.allTabs[onSelectedItem];

    return BottomNavigationBarItem(
        icon: Icon(toBeCreatedTab?.icon), label: toBeCreatedTab?.label);
  }
}
