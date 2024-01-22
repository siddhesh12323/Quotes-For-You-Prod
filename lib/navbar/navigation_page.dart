import 'package:flutter/material.dart';
import 'package:quotes_for_you/screens/about_page.dart';
import 'package:quotes_for_you/screens/favorites_page.dart';
import 'package:quotes_for_you/screens/settings_page.dart';
import '../screens/home_page.dart';
import 'nav_bar.dart';
import 'nav_model.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final transactionNavKey = GlobalKey<NavigatorState>();
  final budgetNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;

  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: const HomePage(), navKey: homeNavKey),
      NavModel(page: const FavoritesPage(), navKey: transactionNavKey),
      NavModel(page: SettingsPage(), navKey: budgetNavKey),
      NavModel(page: const AboutPage(), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () {
          if (items[selectedTab].navKey.currentState!.canPop()) {
            items[selectedTab].navKey.currentState!.pop();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: selectedTab,
            children: items
                .map((e) => Navigator(
                      key: e.navKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => e.page,
                      ),
                    ))
                .toList(),
          ),
          bottomNavigationBar: NavBar(
              pageIndex: selectedTab,
              onTap: (index) {
                if (index == selectedTab) {
                  items[index]
                      .navKey
                      .currentState!
                      .popUntil((route) => route.isFirst);
                } else {
                  setState(() {
                    selectedTab = index;
                  });
                }
              }),
        ));
  }
}
