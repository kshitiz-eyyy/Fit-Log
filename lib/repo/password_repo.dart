abstract class PasswordRepo {
  Future<void> updatePassword(String currentPassword, String newPassword);
}
