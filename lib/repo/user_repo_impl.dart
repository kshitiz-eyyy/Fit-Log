import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ── Fetch admin profile from Firestore ─────────────────────────
  Future<Map<String, dynamic>> getAdminProfile() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore
        .collection('admins')
        .doc(uid)
        .get();
    return doc.data() ?? {};
  }

  // ── Save changed fields to Firestore ───────────────────────────
  Future<void> updateAdminProfile(Map<String, dynamic> data) async {
    final uid = _auth.currentUser!.uid;
    await _firestore
        .collection('admins')
        .doc(uid)
        .set(data, SetOptions(merge: true));
  }

  // ── Upload avatar to Firebase Storage ──────────────────────────
  Future<String> uploadAvatarImage(File image) async {
    final uid = _auth.currentUser!.uid;
    final ref = _storage.ref('avatars/$uid.jpg');
    await ref.putFile(image);
    final url = await ref.getDownloadURL();

    // Save the URL back to Firestore
    await _firestore
        .collection('admins')
        .doc(uid)
        .update({'avatarUrl': url});
    return url;
  }
}