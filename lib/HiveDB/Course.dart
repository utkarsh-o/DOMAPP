import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domapp/HiveDB/Credits.dart';
import 'package:hive/hive.dart';

import '../cache/constants.dart';
import '../cache/models.dart';
import 'Slide.dart';
import 'Professor.dart' as p;

part 'Course.g.dart';

@HiveType(typeId: COURSE_BOX)
class Course extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String branch;

  @HiveField(3)
  int comCode;

  @HiveField(4)
  String courseNo;

  @HiveField(5)
  Credits credits;

  @HiveField(6)
  List<Slide> slides;

  @HiveField(7)
  p.Professor ic;

  @HiveField(8)
  String uid;

  Course({
    required this.name,
    required this.branch,
    required this.credits,
    required this.comCode,
    required this.courseNo,
    required this.ic,
    required this.uid,
    this.slides = const <Slide>[],
  });

  factory Course.fromJson(
      QueryDocumentSnapshot snapshot, p.Professor professor) {
    return Course(
      name: snapshot.get('name'),
      branch: Branch.getBranchFromName(snapshot.get('branch')),
      comCode: snapshot.get('comCode') as int,
      credits: Credits(
        lectures: snapshot.get('lecture'),
        practicals: snapshot.get('practical'),
      ),
      courseNo: snapshot.get('courseNo'),
      ic: professor,
      uid: snapshot.id,
    );
  }

  @override
  String toString() {
    return 'Course{name: $name, branch: $branch, comCode: $comCode, courseNo: $courseNo, credits: $credits, slides: $slides, ic: $ic}';
  }
}
