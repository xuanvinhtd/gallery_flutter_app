import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/models/app/app_tab.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppStart appStart;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key key,
    @required this.appStart,
    @required this.onTabSelected,
  }) : super(key: key);

  IconData _getTabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Icons.home;
      case AppTab.search:
        return Icons.search;
      case AppTab.favorite:
        return Icons.favorite;
    }
    return Icons.home;
  }

  String _getTabTitle(AppTab tab, BuildContext context) {
    switch (tab) {
      case AppTab.home:
        return AppLocalization.of(context).home;
      case AppTab.search:
        return AppLocalization.of(context).search;
      case AppTab.favorite:
        return AppLocalization.of(context).favorite;
    }
    return AppLocalization.of(context).home;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(appStart.tab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            _getTabIcon(tab),
          ),
          label: _getTabTitle(tab, context),
        );
      }).toList(),
    );
  }
}
