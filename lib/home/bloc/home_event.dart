part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends HomeEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class RegisterServiceEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RegisterAccountEvent extends HomeEvent {
  final String username;
  final String password;

  const RegisterAccountEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
