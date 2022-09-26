import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../cache/constants.dart';
import '../cache/models.dart';
import 'Professor.dart' as p;
import 'Course.dart' as c;
part 'Paper.g.dart';

@HiveType(typeId: PAPER_BOX)
class Paper extends HiveObject {
  @HiveField(0)
  String paperUrl; // name schema == year/sem/type/section/slideNumber

  @HiveField(1)
  int sem;

  @HiveField(2)
  c.Course course;

  @HiveField(3)
  p.Professor professor;

  @HiveField(4)
  String paperType;

  @HiveField(5)
  String solutionUrl; // name schema == year/sem/type/section/slideNumber

  @HiveField(6)
  DateTime date;

  @HiveField(7)
  String uid;

  @HiveField(8)
  int average;

  @HiveField(9)
  int highest;

  @HiveField(10)
  int total;

  Paper({
    required this.paperUrl,
    required this.sem,
    required this.course,
    required this.professor,
    required this.paperType,
    required this.solutionUrl,
    required this.date,
    required this.uid,
    required this.average,
    required this.highest,
    required this.total,
  });

  factory Paper.fromSnapshot(
      DocumentSnapshot data, p.Professor prof, c.Course crs) {
    Timestamp date = data.get('date');
    return Paper(
      uid: data.id,
      paperUrl: data.get('paperUrl'),
      sem: data.get('sem'),
      course: crs,
      professor: prof,
      paperType: PaperType.getPaperTypeFromString(data.get('paperType')),
      solutionUrl: data.get('solutionUrl'),
      date: DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
      average: data.get('average') ?? -1,
      highest: data.get('highest') ?? -1,
      total: data.get('total') ?? -1,
    );
  }
  Map<String, dynamic> toJSON() => {
        'average': average,
        'course': course.uid,
        'date': date,
        'highest': highest,
        'paperType': paperType,
        'paperUrl': 'TODO',
        'professor': professor.uid,
        'sem': sem,
        'solutionUrl': 'TODO',
        'total': total,
        'status': 'pending',
      };
  @override
  String toString() {
    return 'Paper{sem: $sem, course: $course, professor: $professor, paperType: $paperType, average: $average, highest: $highest, total: $total}';
  }
}
