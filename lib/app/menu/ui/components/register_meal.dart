import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nutri_app/config/extension.dart';

class RegisterMealDialog extends StatefulWidget {
  const RegisterMealDialog({super.key});

  @override
  State<RegisterMealDialog> createState() => _RegisterMealDialogState();
}

class _RegisterMealDialogState extends State<RegisterMealDialog> {
  bool arrozChecked = false;
  bool ovoChecked = false;
  File? _selectedImage;
  bool isRegistering = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerMeal() async {
    setState(() {
      isRegistering = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simula o registro

    if (mounted) {
      Navigator.of(context).pop(); // Fecha o popup
    }
  }

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
              "Almoço",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text("Arroz"),
                  value: arrozChecked,
                  onChanged: (value) {
                    setState(() {
                      arrozChecked = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Ovo"),
                  value: ovoChecked,
                  onChanged: (value) {
                    setState(() {
                      ovoChecked = value ?? false;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Selecionar Foto"),
            ),
            const SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(context.colorScheme.primary),
              ),
              onPressed: isRegistering ? null : _registerMeal,
              child: isRegistering
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "+ Registrar",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colorScheme.onPrimary),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
