import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/guidelines/cubit/guideline_cubit.dart';
import 'package:nutri_app/app/guidelines/cubit/guideline_states.dart';
import 'package:nutri_app/app/guidelines/models/guideline.dart';
import 'package:nutri_app/app/guidelines/ui/components/guideline_item.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  late final GuidelineCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<GuidelineCubit>(context);
    cubit.fetchGuidelines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Orientações Nutricionais',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF83C5BE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is LoadingGuidelineState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedGuidelineState) {
                return _buildGuidelinesList(state.guidelines);
              } else if (state is ErrorGuidelineState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const Text("Erro desconhecido");
              }
            }),
      ),
    );
  }

  Widget _buildGuidelinesList(List<Guideline> guidelines) {
    return ListView.builder(
      itemCount: guidelines.length,
      itemBuilder: (_, index) {
        final guideline = guidelines[index];

        return GuidelineItem(guideline: guideline);
      },
    );
  }
}
