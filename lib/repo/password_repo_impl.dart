import 'package:firebase_auth/firebase_auth.dart';
import 'password_repo.dart';

class PasswordRepoImpl implements PasswordRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> updatePassword(String currentPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No authenticated user found.");

    // Re-authenticate user before updating password
    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Failed to update password.");
    } catch (e) {
      throw Exception("An unexpected error occurred.");
    }
  }
}
