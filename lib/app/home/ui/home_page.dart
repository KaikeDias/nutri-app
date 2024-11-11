import 'package:flutter/material.dart';
import 'package:nutri_app/app/home/ui/components/home_option.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeOption(
              title: "Chat com o profissional",
              icon: Icons.chat_bubble_outline,
              route: '/',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Diário alimentar",
              icon: Icons.calendar_month,
              route: '/',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Orientações nutricionais",
              icon: Icons.menu_book,
              route: '/',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Impressos",
              icon: Icons.attach_file,
              route: '/',
            ),
          ],
        ),
      ),
    );
  }
}
