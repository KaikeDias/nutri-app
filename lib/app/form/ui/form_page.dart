import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/form/cubit/form_cubit.dart';
import 'package:nutri_app/app/form/cubit/form_states.dart';
import 'package:nutri_app/app/form/models/question.dart';
import 'package:nutri_app/app/form/ui/components/question_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late final FormCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<FormCubit>(context);
    cubit.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Formulário de Anamnese",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF83C5BE),
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer(
        bloc: cubit,
        listener: (context, state) {
          if (state is SuccessFormState) {
            // Exibe um Snackbar de sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Formulário salvo com sucesso!"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ErrorFormState) {
            // Exibe um Snackbar de erro
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingFormState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedFormState) {
            return _buildForm(state.questions);
          } else if (state is ErrorFormState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text("Erro desconhecido"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.saveAnswers(); // Chama o método para salvar as respostas
        },
        label: const Text("Salvar"),
        icon: const Icon(Icons.save),
        backgroundColor: const Color(0xFF83C5BE),
      ),
    );
  }

  Widget _buildForm(List<Question> questions) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (_, index) {
          return QuestionWidget(question: questions[index]);
        },
      ),
    );
  }
}
