import 'dart:io';

sealed class UserEvent {}

final class GetUserProfile extends UserEvent {}

final class UpdateUserProfile extends UserEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;

  UpdateUserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
  });
}

final class UploadProfilePicture extends UserEvent {
  final File imageFile;
  UploadProfilePicture(this.imageFile);
}

final class ChangePasswordPressed extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordPressed({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}