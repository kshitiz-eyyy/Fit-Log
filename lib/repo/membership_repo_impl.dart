import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/membership_model.dart';
import '../utils/firebase_user_helper.dart';
import 'membership_repo.dart';

class MembershipRepoImpl implements MembershipRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> get _userDoc =>
      _firestore.collection('users').doc(FirebaseUserHelper.currentUserId);

  @override
  Future<MembershipModel> fetchMembership() async {
    final doc = await _userDoc.get();
    final data = doc.data();

    if (data == null || data['membership'] == null) {
      final defaults = MembershipModel.defaults();
      await _userDoc.set({'membership': defaults.toMap()}, SetOptions(merge: true));
      return defaults;
    }

    final membership = MembershipModel.fromMap(
      Map<String, dynamic>.from(data['membership'] as Map),
    );

    return _applyElapsedDays(membership);
  }

  MembershipModel _applyElapsedDays(MembershipModel membership) {
    final now = DateTime.now();
    if (now.isBefore(membership.cycleResetDate)) {
      final remaining = membership.cycleResetDate.difference(now).inDays;
      return membership.copyWith(daysRemaining: remaining.clamp(0, membership.totalDays));
    }

    return membership.copyWith(daysRemaining: 0);
  }

  @override
  Future<void> saveMembership(MembershipModel membership) async {
    await _userDoc.set(
      {'membership': membership.toMap()},
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> refreshCycle() async {
    final current = await fetchMembership();
    final refreshed = current.copyWith(
      daysRemaining: current.totalDays,
      cycleResetDate: DateTime.now().add(Duration(days: current.totalDays)),
      isActive: true,
    );
    await saveMembership(refreshed);
  }

  @override
  Future<void> resetProgress() async {
    final current = await fetchMembership();
    final reset = current.copyWith(
      daysRemaining: 0,
      cycleResetDate: DateTime.now(),
      isActive: false,
    );
    await saveMembership(reset);
  }
}
