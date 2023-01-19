part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodosState {
  final List<Task> tasks;
  final String username;

  const TodoLoadedState(this.tasks, this.username);
  @override
  List<Object> get props => [tasks, username];
}
