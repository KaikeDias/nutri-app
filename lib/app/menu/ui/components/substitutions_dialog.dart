import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/menu/cubits/substitutions_cubit.dart';
import 'package:nutri_app/app/menu/cubits/substitutions_states.dart';
import 'package:nutri_app/app/menu/models/food.dart';
import 'package:nutri_app/config/extension.dart';

class SubstitutionsDialog extends StatefulWidget {
  final Food food;

  const SubstitutionsDialog({super.key, required this.food});

  @override
  State<SubstitutionsDialog> createState() => _SubstitutionsDialogState();
}

class _SubstitutionsDialogState extends State<SubstitutionsDialog> {
  late final SubstitutionsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SubstitutionsCubit>(context);
    cubit.fetchSubstitutions(widget.food.id);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color(0xFFDEE4E4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Substituições",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is LoadingSubstitutionsState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedSubstitutionsState) {
                  return _buildSubstitutionsList(state.aliments);
                } else if (state is ErrorSubstitutionsState) {
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
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubstitutionsList(List<Food> substitutions) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: substitutions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 2, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: ListTile(
            title: Text(
              substitutions[index].name,
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.primary),
            ),
            subtitle: Text(
              '${substitutions[index].quantity} ${substitutions[index].unit}',
              style: context.textTheme.labelLarge
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant),
            ),
          ),
        );
      },
    );
  }
}
