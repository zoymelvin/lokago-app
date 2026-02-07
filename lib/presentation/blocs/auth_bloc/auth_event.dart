abstract class AuthEvent {}

class RegisterPressed extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  RegisterPressed({
    required this.email, 
    required this.password, 
    required this.name, 
    required this.phoneNumber
  });
}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});
}