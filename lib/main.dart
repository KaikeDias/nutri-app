import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/auth/cubit/auth_cubit.dart';
import 'package:nutri_app/app/documents/cubit/document_cubit.dart';
import 'package:nutri_app/app/documents/cubit/list_documents_cubit.dart';
import 'package:nutri_app/app/form/cubit/form_cubit.dart';
import 'package:nutri_app/app/goals/cubit/water_goal_cubit.dart';
import 'package:nutri_app/app/guidelines/cubit/guideline_cubit.dart';
import 'package:nutri_app/app/menu/cubits/menu_cubit.dart';
import 'package:nutri_app/app/menu/cubits/substitutions_cubit.dart';
import 'package:nutri_app/app/personalInfo/cubit/personal_info_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MenuCubit()),
        BlocProvider(create: (context) => SubstitutionsCubit()),
        BlocProvider(create: (context) => GuidelineCubit()),
        BlocProvider(create: (context) => PersonalInfoCubit()),
        BlocProvider(create: (context) => ListDocumentsCubit()),
        BlocProvider(create: (context) => DocumentCubit()),
        BlocProvider(create: (context) => WaterGoalCubit()),
        BlocProvider(create: (context) => FormCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme(ThemeData.light().textTheme).light(),
        routerConfig: router,
      ),
    );
  }
}
