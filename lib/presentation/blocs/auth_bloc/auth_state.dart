sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

final class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage);
}