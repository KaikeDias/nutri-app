import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/auth/cubit/auth_cubit.dart';
import 'package:nutri_app/config/extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 1.0; // Inicialmente totalmente opaco
  bool _isAuthenticatedChecked = false;
  
  @override
  void initState() {
    super.initState();

    // Realiza a verificação de autenticação assim que a página for carregada
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final authCubit = context.read<AuthCubit>();

    // Realiza a verificação de autenticação
    await authCubit.checkAuthentication();

    // Agora que a verificação foi concluída, muda o estado para indicar que foi checada
    setState(() {
      _isAuthenticatedChecked = true;
    });

    // Inicia o efeito de fade após a verificação
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 0.0; // Inicia o fade para desaparecer
      });
    });

    await Future.delayed(const Duration(seconds: 1));

    if (authCubit.state.isAuthenticated) {
      context.go('/');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
        ),
        child: Center(
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
