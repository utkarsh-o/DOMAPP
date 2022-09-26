import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../cache/constants.dart';
import '../cache/models.dart';
import 'Paper.dart';
import 'Slide.dart';
import 'User.dart' as u;
import 'Professor.dart' as p;
import 'Course.dart' as c;

part 'Approval.g.dart';

@HiveType(typeId: APPROVAL_BOX)
class Approval extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  int accepts;

  @HiveField(2)
  String description;

  @HiveField(3)
  String reference;

  @HiveField(4)
  int rejects;

  @HiveField(5)
  String approvalType;

  @HiveField(6)
  u.User user;

  @HiveField(7)
  dynamic referredObject;

  @HiveField(8)
  bool alreadyAccepted;

  @HiveField(9)
  bool alreadyRejected;

  Approval(
      {required this.uid,
      required this.accepts,
      required this.description,
      required this.reference,
      required this.rejects,
      required this.approvalType,
      required this.user,
      required this.referredObject,
      required this.alreadyAccepted,
      required this.alreadyRejected});

  factory Approval.fromJson(QueryDocumentSnapshot snapshot, u.User user,
      [Slide? slide, Paper? paper, p.Professor? professor, c.Course? course]) {
    final String approvalType = snapshot.get('type');
    final u.User user = Hive.box('global').get('user');
    dynamic referredObject = ApprovalType.getReferredObject(
      approvalType: approvalType,
      slide: slide,
      paper: paper,
      professor: professor,
      course: course,
    );
    final List<String> acceptedUserUIDs =
        snapshot.get('acceptedBy').cast<String>();
    final List<String> rejectedUserUIDs =
        snapshot.get('rejectedBy').cast<String>();
    print(acceptedUserUIDs.runtimeType);
    return Approval(
      uid: snapshot.id,
      accepts: snapshot.get('accepts'),
      description: snapshot.get('description'),
      reference: snapshot.get('reference'),
      rejects: snapshot.get('rejects'),
      approvalType: approvalType,
      user: user,
      referredObject: referredObject,
      alreadyAccepted: acceptedUserUIDs.contains(user.id),
      alreadyRejected: rejectedUserUIDs.contains(user.id),
    );
  }

  static Map<String, dynamic> toJSON(
      {required String reference, required String approvalType}) {
    final globalBox = Hive.box('global');
    final u.User user = globalBox.get('user');
    return {
      'user': user.id,
      'accepts': 0,
      'description': '',
      'reference': reference,
      'rejects': 0,
      'status': 'pending',
      'type': approvalType,
      'acceptedBy': [],
      'rejectedBy': [],
    };
  }

  @override
  String toString() {
    return 'Approval{accepts: $accepts, description: $description, rejects: $rejects, alreadyAccepted: $alreadyAccepted, alreadyRejected: $alreadyRejected}';
  }
}
