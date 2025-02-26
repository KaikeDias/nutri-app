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
              title: "Informações Pessoais",
              icon: Icons.person,
              route: '/personalInfo',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Formulário de Anamnese",
              icon: Icons.edit_document,
              route: '/form',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Diário alimentar",
              icon: Icons.calendar_month,
              route: '/dietEntry',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Orientações nutricionais",
              icon: Icons.menu_book,
              route: '/guidelines',
            ),
            SizedBox(height: 35),
            HomeOption(
              title: "Impressos",
              icon: Icons.attach_file,
              route: '/documents',
            ),
          ],
        ),
      ),
    );
  }
}
