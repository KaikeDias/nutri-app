import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutri_app/app/goals/ui/goals_page.dart';
import 'package:nutri_app/app/home/ui/home_page.dart';

import '../menu/ui/menu_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, this.initialTabIndex});

  final int? initialTabIndex;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _navigationIndex;

  late final PageController pageController;

  final List<String> _titles = ["Cardápio", "Menu", "Metas"];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _navigationIndex = widget.initialTabIndex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      setupPage();
    });
  }

  @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      setupPage();
    }
  }

  void setupPage() {
    setState(() {
      _navigationIndex = widget.initialTabIndex ?? 0;
      if (_navigationIndex != pageController.page) {
        pageController.jumpToPage(_navigationIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_navigationIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF83C5BE),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline),
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [MenuPage(), HomePage(), GoalsPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (value) async => onBottomNavigationTap(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            label: "Cardápio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.crosshairs),
            label: "Metas",
          ),
        ],
      ),
    );
  }

  void onBottomNavigationTap(int index) {
    setState(() {
      _navigationIndex = index;
      pageController.jumpToPage(index);
    });
  }
}