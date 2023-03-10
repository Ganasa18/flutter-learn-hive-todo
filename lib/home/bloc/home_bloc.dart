import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_hive_todo/services/authentication.dart';
import 'package:flutter_bloc_hive_todo/services/todo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;
  HomeBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);

      if (user != null) {
        emit(SuccessfulLoginState(user));
        emit(HomeInitial());
      }
      // print(event);
    });

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      // print(result);
      switch (result) {
        case UserCreationResult.success:
          emit(SuccessfulLoginState(event.username));
          break;
        case UserCreationResult.failure:
          emit(HomeInitial(error: "There's been an error"));

          break;
        case UserCreationResult.already_exists:
          emit(HomeInitial(error: "User already exists"));
          break;
      }
    });

    on<RegisterServiceEvent>(((event, emit) async {
      await _auth.init();
      await _todo.init();

      emit(HomeInitial());
    }));
  }
}
