import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../cache/constants.dart';
import '../cache/models.dart';
import 'Course.dart' as c;
import 'Professor.dart' as p;
import 'User.dart' as u;
part 'Slide.g.dart';

@HiveType(typeId: SLIDE_BOX)
class Slide extends HiveObject {
  @HiveField(0)
  String url; // name schema == year/sem/type/section/slideNumber

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int sem;

  @HiveField(3)
  int section;

  @HiveField(4)
  c.Course course;

  @HiveField(5)
  p.Professor professor;

  @HiveField(6)
  String slideType; // L == lecture , P == practical

  @HiveField(7)
  int number;

  @HiveField(8)
  String uid;

  @HiveField(9)
  String title;

  Slide({
    required this.url,
    required this.date,
    required this.sem,
    required this.section,
    required this.course,
    required this.professor,
    required this.slideType,
    required this.number,
    required this.uid,
    required this.title,
  });

  factory Slide.fromSnapshot(
      DocumentSnapshot data, p.Professor prof, c.Course crs) {
    Timestamp date = data.get('date');
    return Slide(
        uid: data.id,
        sem: data.get('sem'),
        course: crs,
        url: data.get('url'),
        date: DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
        number: data.get('number'),
        professor: prof,
        section: data.get('section'),
        slideType: SlideType.getPaperTypeFromString(
          data.get('slideType'),
        ),
        title: data.get('title'));
  }

  Map<String, dynamic> toJSON() => {
        'course': course.uid,
        'date': date,
        'number': number,
        'professor': professor.uid,
        'section': section,
        'sem': sem,
        'slideType': slideType,
        'url': url,
        'status': 'pending',
        'title': title
      };

  @override
  String toString() {
    return 'Slide{date: $date, sem: $sem, section: $section, course: ${course.name}, professor: ${professor.name}, slideType: $slideType, number: $number}';
  }
}
