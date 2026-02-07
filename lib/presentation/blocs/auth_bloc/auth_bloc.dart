import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    
    on<RegisterPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authRepository.register(
          email: event.email,
          password: event.password,
          name: event.name,
          phoneNumber: event.phoneNumber,
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          emit(AuthSuccess("Registrasi Berhasil! Silakan Login."));
        }
      } catch (e) {
        emit(AuthError("Registrasi Gagal: ${e.toString()}"));
      }
    });

on<LoginPressed>((event, emit) async {
  emit(AuthLoading());
  try {
    final response = await authRepository.login(event.email, event.password);
    
    if (response.data != null) {
      final token = response.data['token'] ?? response.data['data'];

      if (token != null && token is String) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        
        emit(AuthSuccess("Login Berhasil!"));
      } else {
        emit(AuthError("Token ditemukan tapi formatnya salah atau kosong."));
      }
    }
  } catch (e) {
    emit(AuthError("Login Gagal: Periksa kembali email dan password."));
  }
});
  }
}