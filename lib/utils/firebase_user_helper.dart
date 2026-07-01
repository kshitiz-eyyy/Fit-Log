import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserHelper {
  static const String fallbackUserId = 'Eb3LsmAGcqNpd5pfwO28TpPyFWL2';

  static String get currentUserId {
    return FirebaseAuth.instance.currentUser?.uid ?? fallbackUserId;
  }
}
