import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/dietEntry/cubit/diet_entry_cubit.dart';
import 'package:nutri_app/app/dietEntry/cubit/diet_entry_states.dart';
import 'package:nutri_app/app/dietEntry/ui/components/diet_entry_widget.dart';

class DietEntryPage extends StatefulWidget {
  const DietEntryPage({super.key});

  @override
  State<DietEntryPage> createState() => _DietEntryPageState();
}

class _DietEntryPageState extends State<DietEntryPage> {
  late final DietEntryCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DietEntryCubit>(context);
    cubit.fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Diário Alimentar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF83C5BE),
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoadingDietEntryState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedDietEntryState) {
              return EntriesList(entries: state.entries);
            } else if (state is ErrorDietEntryState) {
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
}
