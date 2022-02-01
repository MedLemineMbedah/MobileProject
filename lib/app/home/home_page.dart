import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/account/account_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/cupertino_home_scaffold.dart';
import 'package:starter_architecture_flutter_firebase/app/home/projet/jobs_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.projet;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.projet: GlobalKey<NavigatorState>(),
   
   };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
     TabItem.account: (_) => AccountPage(),
     TabItem.projet: (_) => ProjetPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !(await navigatorKeys[_currentTab]!.currentState?.maybePop() ??
              false),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
