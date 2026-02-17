import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;

  UserBloc(this.authRepository) : super(UserInitial()) {
    on<GetUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await authRepository.getLoggedUser();
        emit(UserSuccess(user));
      } catch (e) {
        emit(UserError("Gagal mengambil profil: ${e.toString()}"));
      }
    });

    on<UpdateUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        await authRepository.updateProfile(
          name: event.name,
          email: event.email,
          phoneNumber: event.phoneNumber,
          profilePictureUrl: event.profilePictureUrl,
        );
        
        final updatedUser = await authRepository.getLoggedUser();
        emit(UserSuccess(updatedUser));
      } catch (e) {
        emit(UserError("Gagal memperbarui profil: ${e.toString()}"));
      }
    });
    
    on<UploadProfilePicture>((event, emit) async {
      final currentState = state;
      if (currentState is UserSuccess) {
        emit(UserLoading());
        try {
          final newImageUrl = await authRepository.uploadImage(event.imageFile);
          
          await authRepository.updateProfile(
            name: currentState.user.name ?? "",
            email: currentState.user.email ?? "",
            phoneNumber: currentState.user.phoneNumber ?? "",
            profilePictureUrl: newImageUrl,
          );

          final updatedUser = await authRepository.getLoggedUser();
          emit(UserSuccess(updatedUser));
        } catch (e) {
          emit(UserError("Gagal upload gambar: ${e.toString()}"));
          emit(UserSuccess(currentState.user)); 
        }
      }
    });


    on<ChangePasswordPressed>((event, emit) async {
      emit(UserLoading());
      try {
        await authRepository.updatePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
          confirmNewPassword: event.confirmPassword,
        );
        final user = await authRepository.getLoggedUser();
        emit(UserSuccess(user)); 
      } catch (e) {
        emit(UserError("Gagal mengganti password: ${e.toString()}"));
      }
    });
  }
}