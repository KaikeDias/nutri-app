import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/auth/models/patient.dart';
import 'package:nutri_app/app/personalInfo/cubit/personal_info_cubit.dart';
import 'package:nutri_app/app/personalInfo/cubit/personal_info_state.dart';
import 'package:nutri_app/app/personalInfo/ui/components/info_item.dart';
import 'package:nutri_app/config/extension.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late final PersonalInfoCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<PersonalInfoCubit>(context);
    cubit.fetchPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF83C5BE),
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          'Informações Pessoais',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoadingPersonalInfoState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedPersonalInfoState) {
              return personalInfoWidget(state.patient);
            } else if (state is ErrorPersonalInfoState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Text("Erro desconhecido");
            }
          },
        ),
      ),
    );
  }

  Widget personalInfoWidget(Patient patient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoItem(
          title: 'Nome Completo',
          subtitle: patient.name,
          icon: Icons.person,
        ),
        InfoItem(
          title: 'Email',
          subtitle: patient.email,
          icon: Icons.mail,
        ),
        InfoItem(
          title: 'Nome de Usuário',
          subtitle: patient.username,
          icon: Icons.account_circle_outlined,
        ),
        InfoItem(
          title: 'Celular',
          subtitle: patient.phone,
          icon: Icons.phone,
        ),
        InfoItem(
          title: 'CPF',
          subtitle: patient.cpf,
          icon: Icons.badge,
        ),
      ],
    );
  }
}
