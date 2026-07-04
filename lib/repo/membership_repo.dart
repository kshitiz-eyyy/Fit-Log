import '../model/membership_model.dart';

abstract class MembershipRepo {
  Future<MembershipModel> fetchMembership();
  Future<void> saveMembership(MembershipModel membership);
  Future<void> refreshCycle();
  Future<void> resetProgress();
}
