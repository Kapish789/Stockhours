import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:stock_hours/screens/markets_screen.dart';
import 'package:stock_hours/screens/settings_screen.dart';
import 'package:stock_hours/screens/timeline_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      backgroundColor: Theme.of(context).colorScheme.background,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeOutCubic,
      ),
      controller: _controller,
      navBarStyle: NavBarStyle.style11,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.barsStaggered,
            size: 20,
          ),
          title: "Timeline",
          activeColorSecondary: CupertinoColors.activeBlue,
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.store,
            size: 20,
          ),
          activeColorSecondary: CupertinoColors.activeBlue,
          title: "Markets",
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.gear,
            size: 20,
          ),
          activeColorSecondary: CupertinoColors.activeBlue,
          title: "Settings",
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      screens: const [
        TimelineScreen(),
        MarketsScreen(),
        SettingsScreen(),
      ],
    );
  }
}
