import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../HiveDB/Approval.dart';
import '../../HiveDB/User.dart' as u;
import '../../cache/models.dart';

enum ApprovalUpdateType { accepts, rejects }

updateAdminCount() async {
  final firestore = FirebaseFirestore.instance;
  QuerySnapshot usersSnapshot = await firestore
      .collection('Users')
      .where('type', isEqualTo: UserType.admin)
      .get();
  final numAdmins = usersSnapshot.docs.length;
  await Hive.box('global').put('numAdmins', numAdmins);
}

updateAcceptsRejects(
    {required Approval approval,
    required ApprovalUpdateType approvalUpdateType,
    required int updatedValue}) async {
  final firestore = FirebaseFirestore.instance;
  final approvalRef = firestore.doc('Approvals/${approval.uid}');
  final u.User user = Hive.box('global').get('user');
  final int numAdmins = Hive.box('global').get('numAdmins');

  //TODO: decide approval logic based on admin majority
  //TODO: MAKE THIS LESS BULLSHIT
  if (approvalUpdateType == ApprovalUpdateType.accepts) {
    if (approval.alreadyRejected) {
      await approvalRef.update({
        'rejectedBy': FieldValue.arrayRemove([user.id]),
        'rejects': FieldValue.increment(-1),
      });
    }
    if (approval.alreadyAccepted) {
      await approvalRef.update({
        'accepts': FieldValue.increment(-1),
        'acceptedBy': FieldValue.arrayRemove([user.id]),
      });
      return;
    }
    await firestore.doc('Approvals/${approval.uid}').update({
      'accepts': FieldValue.increment(1),
      'acceptedBy': FieldValue.arrayUnion([user.id])
    });
    if (updatedValue >= (0.6 * numAdmins).ceil()) {
      await firestore.doc('Approvals/${approval.uid}').update({
        'status': 'accepted',
      });
      await firestore
          .doc(
              '${ApprovalType.getFirestoreCollection(approval.approvalType) ?? ''}/${approval.reference}')
          .update({
        'status': 'accepted',
      });
    }
  } else if (approvalUpdateType == ApprovalUpdateType.rejects) {
    if (approval.alreadyAccepted) {
      await approvalRef.update({
        'accepts': FieldValue.increment(-1),
        'acceptedBy': FieldValue.arrayRemove([user.id]),
      });
    }
    if (approval.alreadyRejected) {
      await approvalRef.update({
        'rejectedBy': FieldValue.arrayRemove([user.id]),
        'rejects': FieldValue.increment(-1),
      });
      return;
    }
    await firestore.doc('Approvals/${approval.uid}').update({
      'rejects': FieldValue.increment(1),
      'rejectedBy': FieldValue.arrayUnion([user.id])
    });
    if (updatedValue >= (0.5 * numAdmins).ceil()) {
      await firestore.doc('Approvals/${approval.uid}').update({
        'status': 'rejected',
      });
      await firestore
          .doc(
              '${ApprovalType.getFirestoreCollection(approval.approvalType) ?? ''}/${approval.reference}')
          .update({
        'status': 'rejected',
      });
    }
  }
}
