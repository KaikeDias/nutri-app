import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/dietEntry/cubit/entry_cubit.dart';
import 'package:nutri_app/app/dietEntry/models/diet_entry.dart';
import 'package:nutri_app/app/dietEntry/models/diet_entry_dto.dart';
import 'package:nutri_app/app/dietEntry/ui/components/entry_dialog.dart';

class EntriesPage extends StatefulWidget {
  final String date;
  final List entries;

  const EntriesPage({super.key, required this.date, required this.entries});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  late final DietEntry dietEntry;
  late final EntryCubit cubit;
  final List<String> entriesEx = ["Almoço"];

  @override
  void initState() {
    super.initState();
    // cubit = BlocProvider.of<EntryCubit>(context);
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EntryDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registros de 12/02/2025",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF83C5BE),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: entriesEx.length,
        itemBuilder: (context, index) {
          final String entry =
              entriesEx[index]; // Aqui você ajusta como exibir os registros
          return Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: InkWell(
              onTap: () async {
                // DietEntry? selectedEntry = await cubit.fetchEntry(entry.id);
                _showPopup(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: const Icon(Icons.check_box),
                  title: Text(entry), // Exibindo o título do registro
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
