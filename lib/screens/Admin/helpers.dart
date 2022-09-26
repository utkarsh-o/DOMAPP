import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../HiveDB/Approval.dart';
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
  await firestore.doc('Approvals/${approval.uid}').update({
    approvalUpdateType == ApprovalUpdateType.accepts ? 'accepts' : 'rejects':
        updatedValue
  });
  final int numAdmins = Hive.box('global').get('numAdmins');
  if (approvalUpdateType == ApprovalUpdateType.accepts) {
    //TODO: decide approval logic based on admin majority
    if (updatedValue >= (0.6 * numAdmins).ceil()) {
      await firestore
          .doc('Approvals/${approval.uid}')
          .update({'status': 'accepted'});
    }
  } else if (approvalUpdateType == ApprovalUpdateType.rejects) {
    if (updatedValue >= (0.5 * numAdmins).ceil()) {
      await firestore
          .doc('Approvals/${approval.uid}')
          .update({'status': 'rejected'});
    }
  }
}
