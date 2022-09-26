import 'package:hive/hive.dart';

import '../cache/constants.dart';
import '../cache/models.dart';

part 'Professor.g.dart';

@HiveType(typeId: PROF_BOX)
class Professor extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String id;

  @HiveField(2)
  String branch;

  @HiveField(3)
  String chamber;

  @HiveField(4)
  String uid;

  Professor({
    required this.name,
    required this.id,
    required this.branch,
    required this.chamber,
    required this.uid,
  });

  factory Professor.fromSnapshot(data) {
    return Professor(
      uid: data.id,
      name: data.get('name'),
      branch: Branch.getBranchFromName(data.get('branch')),
      chamber: data.get('chamber'),
      id: data.get('id'),
    );
  }

  @override
  String toString() {
    return 'Professor{name: $name, id: $id, branch: $branch, chamber: $chamber}';
  }
}
