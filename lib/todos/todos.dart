import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_hive_todo/services/todo.dart';

import 'bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({
    super.key,
    required this.username,
  });
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos List'),
      ),
      body: BlocProvider(
        create: (context) => TodosBloc(
          RepositoryProvider.of<TodoService>(context),
        )..add(LoadTodosEvent(username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodoLoadedState) {
              return ListView(
                children: [
                  ...state.tasks.map(
                    (e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.completed,
                        onChanged: (value) {
                          BlocProvider.of<TodosBloc>(context).add(
                            ToggleTodoState(
                              e.task,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Create New'),
                    trailing: const Icon(Icons.edit),
                    onTap: () async {
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => const Dialog(
                          child: CreatNewTask(),
                        ),
                      );

                      if (result != null) {
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<TodosBloc>(context).add(
                          AddTodoEvent(result),
                        );
                      }
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreatNewTask extends StatefulWidget {
  const CreatNewTask({super.key});

  @override
  State<CreatNewTask> createState() => _CreatNewTaskState();
}

class _CreatNewTaskState extends State<CreatNewTask> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('What task do you want to create ?'),
        TextField(
          controller: _inputController,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_inputController.text);
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
