part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final String? error;

  const HomeInitial({this.error});
  // const HomeInitial({this.success});
  @override
  List<Object> get props => [error.toString()];
}

class SuccessfulLoginState extends HomeState {
  final String username;

  const SuccessfulLoginState(this.username);
  @override
  List<Object> get props => [username];
}

class RegisteringServiceState extends HomeState {
  @override
  List<Object> get props => [];
}
