import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/models/app/app_tab.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppStart? appStart;
  final Function(AppTab)? onTabSelected;

  const TabSelector({
    Key? key,
    @required this.appStart,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(appStart?.tab ?? AppTab.photo),
      onTap: (index) => onTabSelected!(AppTab.values[index]),
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

  IconData _getTabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.photo:
        return Icons.photo;
      case AppTab.cloud:
        return Icons.cloud_queue;
    }
  }

  String _getTabTitle(AppTab tab, BuildContext context) {
    switch (tab) {
      case AppTab.photo:
        return AppLocalization.of(context).photos;
      case AppTab.cloud:
        return AppLocalization.of(context).cloud;
    }
  }
}
