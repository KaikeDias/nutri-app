import 'package:flutter/material.dart';
import 'package:nutri_app/app/routes/router.dart';
import 'package:nutri_app/config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
      routerConfig: router,
    );
  }
}
