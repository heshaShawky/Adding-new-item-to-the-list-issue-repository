part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserState {}

class UserLoginLoading extends UserState {}

class UserLoginFailure extends UserState {
  final String error;

  const UserLoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
