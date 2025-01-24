import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/auth/ui/login_page.dart';
import 'package:nutri_app/app/auth/ui/splash_page.dart';
import 'package:nutri_app/app/guidelines/ui/guidelines_page.dart';
import 'package:nutri_app/app/menu/ui/menu_page.dart';
import 'package:nutri_app/app/personalInfo/ui/personal_info_page.dart';
import 'package:nutri_app/app/routes/main_layout.dart';

final router = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
    path: "/",
    name: 'MainLayout',
    builder: (_, __) => const MainLayout(initialTabIndex: 0),
    routes: [
    GoRoute(
      path: 'menu',
      name: 'menu',
      builder: (_, __) => const MenuPage(),
    ),
    GoRoute(
      path: 'home',
      name: 'home',
      builder: (_, __) => const MainLayout(initialTabIndex: 1),
    ),
    GoRoute(
      path: 'goals',
      name: 'goals',
      builder: (_, __) => const MainLayout(initialTabIndex: 2),
    ),
  ],
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (_, __) => const LoginPage(),
  ),
  GoRoute(
    path: '/splash',
    name: 'splash',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: '/guidelines',
    name: 'guidelines',
    builder: (context, state) => const GuidelinesPage(),
  ),
  GoRoute(
    path: '/personalInfo',
    name: 'personalInfo',
    builder: (context, state) => const PersonalInfoPage(),
  )
]);
