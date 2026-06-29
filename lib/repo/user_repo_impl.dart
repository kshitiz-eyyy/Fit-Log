import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_repo.dart';
import '../model/user_model.dart';

class UserRepoImpl implements UserRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel userModel) {
    return firestore
        .collection("users")
        .doc(userModel.id)
        .set(userModel.toMap());
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<void> deleteUser(String id) {
    return firestore.collection("users").doc(id).delete();
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<void> editProfile(UserModel userModel) {
    return firestore
        .collection("users")
        .doc(userModel.id)
        .update(userModel.toMap());
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<void> forgetPassword(String email) {
    return auth.sendPasswordResetEmail(email: email);
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<List<UserModel>> getAllUser() async {
    final snapshot = await firestore.collection("users").get();
    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .toList();
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<UserModel> getUserByID(String id) async {
    final doc = await firestore.collection("users").doc(id).get();
    final data = doc.data();

    if (data == null) {
      throw Exception("User not found");
      @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}
    return UserModel.fromMap(data);
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<String> login(String email, String password) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = userCredential.user?.uid;

    if (userId == null) {
      throw Exception("Login failed");
      @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}
    return userId;
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<void> logout() {
    return auth.signOut();
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}

  @override
  Future<String> register(String email, String password) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = userCredential.user?.uid;

    if (userId == null) {
      throw Exception("Registration failed");
      @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}
    return userId;
    @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}
  @override
  Future<void> terminateAccount() async {
    final user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      // Delete from Firestore first
      await firestore.collection("users").doc(uid).delete();
      // Delete from Auth
      await user.delete();
    }
  }
}