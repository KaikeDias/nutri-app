import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/menu/ui/menu_page.dart';
import 'package:nutri_app/app/routes/main_layout.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: "/",
    name: 'MainLayout',
    builder: (_, __) => const MainLayout(initialTabIndex: 0),
    routes: [
      GoRoute(
        path: 'menu',
        builder: (_, __) => const MenuPage(),
      ),
    ],
  ),
  GoRoute(
    path: '/home',
    name: 'home',
    builder: (_, __) => const MainLayout(initialTabIndex: 1),
  ),
  GoRoute(
    path: '/goals',
    name: 'goals',
    builder: (_, __) => const MainLayout(initialTabIndex: 2),
  )
]);