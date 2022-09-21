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

  User({
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.collegeID,
  });
}
