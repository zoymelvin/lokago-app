import '../../../data/models/user_model.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel user;
  UserSuccess(this.user);
}

final class UserError extends UserState {
  final String errorMessage;
  UserError(this.errorMessage);
}