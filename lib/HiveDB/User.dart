import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../cache/constants.dart';

part 'User.g.dart';

@HiveType(typeId: USER_BOX)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? photoUrl;

  @HiveField(2)
  String email;

  @HiveField(3)
  String collegeID;

  @HiveField(4)
  String id;

  @HiveField(5)
  String type;

  User({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.type,
    this.collegeID = '',
  });

  factory User.fromJSON(DocumentSnapshot snapshot) {
    return User(
        id: snapshot.id,
        name: snapshot.get('name'),
        photoUrl: snapshot.get('photoUrl'),
        type: snapshot.get('type'),
        email: snapshot.get('email'));
  }

  Map<String, dynamic> toJSON() {
    return {
      'collegeID': collegeID,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'type': type,
    };
  }
}
