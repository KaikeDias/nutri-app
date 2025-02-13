import 'package:flutter/material.dart';
import 'package:nutri_app/app/dietEntry/models/diet_entry.dart';
import 'package:nutri_app/config/extension.dart';

class EntryDialog extends StatefulWidget {
  const EntryDialog({super.key});

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Almoco",
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
                height: 120, // Ajuste conforme necessário
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.check_box),
                      title: Text("Arroz"),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_box),
                      title: Text("Ovo"),
                    ),
                  ],
                )),
            const Divider(),
            SizedBox(
              height: 180, // Defina a altura desejada
              width: 180, // Defina a largura desejada
              child: Image.network(
                "https://oestadoonline.com.br/wp-content/uploads/2023/06/arrozcomovo.png",
                fit: BoxFit.cover, // Ajusta a imagem no espaço
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    color:
                        Colors.red), // Ícone de erro caso a imagem não carregue
              ),
            ),
          ],
        ),
      ),
    );
  }
}
