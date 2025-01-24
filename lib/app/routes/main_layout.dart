import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/auth/cubit/auth_cubit.dart';
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
  final AuthCubit _authCubit = AuthCubit();

  late final PageController pageController;

  final List<String> _titles = ["Cardápio", "Menu"];

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (!state.isAuthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
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
              onPressed: () async {
                await _authCubit.logout();
              },
              icon: const Icon(Icons.logout),
            )),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MenuPage(),
            HomePage(),
          ],
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
            )
          ],
        ),
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
