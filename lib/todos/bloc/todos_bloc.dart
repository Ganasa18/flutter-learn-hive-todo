import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_hive_todo/services/todo.dart';

import '../../models/task.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;
  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodoLoadedState(todos, event.username));
      // TODO: implement event handler
    });

    on<AddTodoEvent>((event, emit) {
      final currentState = state as TodoLoadedState;
      _todoService.addTask(event.todoText, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<ToggleTodoState>((event, emit) async {
      final currentState = state as TodoLoadedState;

      await _todoService.updateTask(event.todoTask, currentState.username);

      add(LoadTodosEvent(currentState.username));
    });
  }
}
