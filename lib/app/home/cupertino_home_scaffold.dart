import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/tab_item.dart';
import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
//import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';

@immutable
class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: const Key(Keys.tabBar),
        currentIndex: currentTab.index,
        items: [
          
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
          _buildItem(TabItem.projet),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
        activeColor: Colors.indigo,
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item]!(context),
        //  onGenerateRoute: CupertinoTabViewRouter.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem]!;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon),
      label: itemData.title,
    );
  }
}
