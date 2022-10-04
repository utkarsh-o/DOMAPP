import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../../HiveDB/Approval.dart';
import '../../../HiveDB/Course.dart';
import '../../../HiveDB/Paper.dart';
import '../../../HiveDB/Professor.dart';
import '../../../HiveDB/Slide.dart';
import '../../../cache/models.dart' as m;

getAllProfessors() async {
  final globalBox = Hive.box('global');
  final firestore = FirebaseFirestore.instance;
  QuerySnapshot professorSnapshot =
      await firestore.collection('Professors').get();
  final List<Professor> professors =
      professorSnapshot.docs.map((doc) => Professor.fromSnapshot(doc)).toList();
  await globalBox.put('professors', professors);
}

getAllCourses() async {
  await getAllProfessors();
  final firestore = FirebaseFirestore.instance;
  final globalBox = Hive.box('global');
  final professors =
      await globalBox.get('professors', defaultValue: <Professor>[]);

  QuerySnapshot courseSnapshot = await firestore.collection('Courses').get();
  final List<Course> courses = courseSnapshot.docs.map((data) {
    final profUID = data.get('professor');
    final prof = professors.firstWhere((Professor prof) => prof.uid == profUID);
    return Course.fromJson(data, prof);
  }).toList();
  await globalBox.put('allCourses', courses);
}

getPapersFromCourse({required String courseID}) async {
  final firestore = FirebaseFirestore.instance;
  final papersBox = Hive.box('papers');
  final globalBox = Hive.box('global');
  final professors =
      await globalBox.get('professors', defaultValue: <Professor>[]);
  final List<Course> courses =
      await globalBox.get('allCourses', defaultValue: <Course>[]);

  QuerySnapshot paperSnapshot = await firestore
      .collection('Papers')
      .where('course', isEqualTo: courseID)
      .get();
  final List<Paper> papers = paperSnapshot.docs.map((data) {
    final profUID = data.get('professor');
    final professor =
        professors.firstWhere((Professor prof) => prof.uid == profUID);
    final crsUID = data.get('course');
    final course = courses.firstWhere((Course crs) => crs.uid == crsUID);
    return Paper.fromSnapshot(data, professor, course);
  }).toList();
  await papersBox.put(courseID, papers);
}

getSlidesFromCourse({required String courseID}) async {
  final firestore = FirebaseFirestore.instance;
  final slidesBox = Hive.box('slides');
  final globalBox = Hive.box('global');
  final professors =
      await globalBox.get('professors', defaultValue: <Professor>[]);
  final List<Course> courses =
      await globalBox.get('allCourses', defaultValue: <Course>[]);

  QuerySnapshot slideSnapshot = await firestore
      .collection('Slides')
      .where('course', isEqualTo: courseID)
      .where('status', isEqualTo: 'accepted')
      .get();
  final List<Slide> slides = slideSnapshot.docs.map((data) {
    final profUID = data.get('professor');
    final professor =
        professors.firstWhere((Professor prof) => prof.uid == profUID);
    final crsUID = data.get('course');
    final course = courses.firstWhere((Course crs) => crs.uid == crsUID);
    return Slide.fromSnapshot(data, professor, course);
  }).toList();
  await slidesBox.put(courseID, slides);
}

addCourseToFirebase() async {
  final firestore = FirebaseFirestore.instance;
  await firestore.collection('Courses').add({
    'branch': 'mathematics',
    'comCode': 654321,
    'courseNo': "F123",
    'lecture': 3,
    'name': 'Statistical Inference',
    'practical': 0,
    'professor': 'KQp0zZF7nFBXjKa9V64Z'
  }).then((value) => print(value));
}

createSlideApproval({required Slide slide}) async {
  final firestore = FirebaseFirestore.instance;
  String slideReference = '';
  String approvalReference = '';
  await firestore
      .collection('Slides')
      .add(slide.toJSON())
      .then((value) => slideReference = value.id);
  Map<String, dynamic> approval = Approval.toJSON(
      reference: slideReference, approvalType: m.ApprovalType.createSlide);
  await firestore
      .collection('Approvals')
      .add(approval)
      .then((value) => approvalReference = value.id);
  await firestore
      .collection('Slides')
      .doc(slideReference)
      .update({'approval': approvalReference});
}

createPaperApproval({required Paper paper}) async {
  final firestore = FirebaseFirestore.instance;
  String paperReference = '';
  String approvalReference = '';
  await firestore
      .collection('Papers')
      .add(paper.toJSON())
      .then((value) => paperReference = value.id);
  Map<String, dynamic> approval = Approval.toJSON(
      reference: paperReference, approvalType: m.ApprovalType.createPaper);
  await firestore
      .collection('Approvals')
      .add(approval)
      .then((value) => approvalReference = value.id);
  await firestore
      .collection('Papers')
      .doc(paperReference)
      .update({'approval': approvalReference});
}
