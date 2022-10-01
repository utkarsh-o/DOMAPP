import 'package:domapp/cache/local_data.dart';
import '../HiveDB/Paper.dart';
import '../HiveDB/Slide.dart';
import '../HiveDB/Course.dart' as c;
import '../HiveDB/Professor.dart' as p;

class Professor {
  String name, uid;
  List<String> branches;
  Professor({required this.name, required this.branches, required this.uid});
}

class Post {
  String title;
  User author;
  List<String> tags;
  DateTime dateCreated;
  int likes, comments;
  Post({
    required this.title,
    required this.author,
    required this.dateCreated,
    required this.tags,
    required this.likes,
    required this.comments,
  });
}

class Comment {
  String text;
  User author;
  int likes;
  Comment({
    required this.author,
    required this.likes,
    required this.text,
  });
}

class DiscussionReply {
  String text, tag;
  String? attachmentUrl;
  User user;
  int thumbsUP, thumbsDown;
  DiscussionReply(
      {required this.text,
      required this.tag,
      this.attachmentUrl,
      required this.thumbsDown,
      required this.thumbsUP,
      required this.user});
}

class AdminAction {
  String title;
  User user;
  int approvals, reports;
  AdminAction(
      {required this.title,
      required this.user,
      required this.approvals,
      required this.reports});
}

class Branch {
  static String chemical = 'chemical';
  static String eee = 'eee';
  static String eni = 'eni';
  static String ece = 'ece';
  static String mechanical = 'mechanical';
  static String computerScience = 'computerScience';
  static String biology = 'biology';
  static String chemistry = 'chemistry';
  static String economics = 'economics';
  static String mathematics = 'mathematics';
  static String physics = 'physics';
  static String humanities = 'humanities';
  static String utility = 'utility';

  static String getBranchFromName(String name) {
    switch (name) {
      case 'chemical':
        return Branch.chemical;
      case 'eee':
        return Branch.eee;
      case 'eni':
        return Branch.eni;
      case 'ece':
        return Branch.ece;
      case 'mechanical':
        return Branch.mechanical;
      case 'computerScience':
        return Branch.computerScience;
      case 'biology':
        return Branch.biology;
      case 'chemistry':
        return Branch.chemistry;
      case 'economics':
        return Branch.economics;
      case 'mathematics':
        return Branch.mathematics;
      case 'physics':
        return Branch.physics;
      case 'humanities':
        return Branch.humanities;
      default:
        return '';
    }
  }
}

class PaperType {
  static String all = 'all';
  static String quiz = 'quiz';
  static String test = 'test';
  static String midSem = 'midSem';
  static String comprehensive = 'comprehensive';
  static String lab = 'lab';
  static String assignment = 'assignment';

  static String getPaperTypeFromString(String name) {
    switch (name) {
      case 'quiz':
        return PaperType.quiz;
      case 'test':
        return PaperType.test;
      case 'midSem':
        return PaperType.midSem;
      case 'comprehensive':
        return PaperType.comprehensive;
      case 'lab':
        return PaperType.lab;
      case 'assignment':
        return PaperType.assignment;
      default:
        return '';
    }
  }

  static List<String> paperTypes = [
    quiz,
    test,
    midSem,
    comprehensive,
    lab,
    assignment
  ];
}

class SlideType {
  static String lecture = 'lecture';
  static String practical = 'practical';

  static String getPaperTypeFromString(String name) {
    switch (name) {
      case 'lecture':
        return SlideType.lecture;
      case 'practical':
        return SlideType.practical;
      default:
        return '';
    }
  }

  static List<String> slideTypes = [lecture, practical];
}

class Session {
  int year;
  int sem;
  DateTime date;
  static final int startYear = 2012;

  Session({required this.year, required this.sem})
      : date = DateTime(
            year,
            sem == 1
                ? 8
                : 1); // chosen august to denote first sem and jan for the second sem

  static List<int> yearList = [
    for (int i = 0; i <= DateTime.now().year - startYear; i++) i + startYear
  ];
  static List<Session> sessions = [
    for (int year in yearList)
      for (int sem in [1, 2]) Session(year: year, sem: sem)
  ];
  @override
  String toString() => '${this.year} (${this.sem == 1 ? 'I' : 'II'})';

  factory Session.fromDate(DateTime date) =>
      Session(year: date.year, sem: date.month == 8 ? 1 : 2);

//  USE-CASE EXAMPLES
//  1. SESSION DROPDOWN FOR UPLOAD-SLIDE PAGE
//      Session.sessions.forEach((Session ssn) => print(ssn));
}

class User {
  String firstName, lastName, userName, gender, type;
  int avatarID, UID;
  User(
      {required this.firstName,
      required this.avatarID,
      required this.UID,
      required this.gender,
      required this.type,
      required this.lastName,
      required this.userName});
  String get fullName => '$firstName $lastName';
  String get avatar => getAvatarByID(avatarID, gender);
}

// enum Branch {
//   Chemical,
//   ElectronicsAndElectrical,
//   ElectronicsAndInstrumentation,
//   ElectronicsAndCommunication,
//   Mechanical,
//   ComputerScience,
//   Biology,
//   Chemistry,
//   Economics,
//   Mathematics,
//   Physics,
//   Humanities,
//   utility
// }
//
// extension BranchExt on Branch {
//   getBranchFromName(String name) {
//     switch (name) {
//       case 'chemical':
//         return Branch.Chemical;
//       case 'eee':
//         return Branch.ElectronicsAndElectrical;
//       case 'eni':
//         return Branch.ElectronicsAndInstrumentation;
//       case 'ece':
//         return Branch.ElectronicsAndCommunication;
//       case 'mechanical':
//         return Branch.Mechanical;
//       case 'computerScience':
//         return Branch.ComputerScience;
//       case 'biology':
//         return Branch.Biology;
//       case 'chemistry':
//         return Branch.Chemistry;
//       case 'economics':
//         return Branch.Economics;
//       case 'mathematics':
//         return Branch.Mathematics;
//       case 'physics':
//         return Branch.Physics;
//       case 'humanities':
//         return Branch.Humanities;
//     }
//   }
// }

// class Credits {
//   int practicals;
//   int lectures;
//   int units;
//
//   Credits({required this.lectures, required this.practicals})
//       : this.units = practicals + lectures;
// }

class Course {
  Professor professor;
  String title, type;
  Branch branch;
  int idNumber;
  Course({
    required this.title,
    required this.idNumber,
    required this.branch,
    required this.professor,
    required this.type,
  });
  // String getBranchName() {
  //   switch (branch) {
  //     case Branch.Humanities:
  //       return 'Humanities';
  //     default:
  //       return 'Unknown';
  //   }
  // }
  //
  // String getIDName() {
  //   switch (branch) {
  //     case Branch.Humanities:
  //       return 'HSS';
  //     default:
  //       return 'unknown';
  //   }
  // }
}

class Tag {
  String title;
  int votes;
  Tag({required this.title, required this.votes});
}

class ApprovalType {
  static const String createSlide = 'createSlide';
  static const String updateSlide = 'updateSlide';
  static const String createPaper = 'createPaper';
  static const String updatePaper = 'updatePaper';
  static const String addProfessor = 'addProfessor';
  static const String addCourse = 'addCourse';
  static const String ticket = 'ticket';

  static List<String> approvalTypes = [
    createSlide,
    updateSlide,
    createPaper,
    updatePaper,
    addProfessor,
    addCourse,
    ticket
  ];

  static getReferredObject(
      {required String approvalType,
      required Slide? slide,
      required Paper? paper,
      required p.Professor? professor,
      required c.Course? course}) {
    switch (approvalType) {
      case createSlide:
        return slide;
      case updateSlide:
        return slide;
      case createPaper:
        return paper;
      case updatePaper:
        return paper;
      default:
        return null;
    }
  }

  static String getDescription(String approvalType) {
    switch (approvalType) {
      case ApprovalType.createSlide:
        return 'Added Slide';
      case ApprovalType.updateSlide:
        return 'Updated Slide';
      case ApprovalType.createPaper:
        return 'Added Paper';
      case ApprovalType.updatePaper:
        return 'Updated Paper';
      case ApprovalType.addCourse:
        return 'Added Course';
      case ApprovalType.addProfessor:
        return 'Added Professor';
      default:
        return '{{ $approvalType }}';
    }
  }

  static String? getFirestoreCollection(String approvalType) {
    switch (approvalType) {
      case ApprovalType.createSlide:
        return 'Slides';
      case ApprovalType.updateSlide:
        return 'Slides';
      case ApprovalType.createPaper:
        return 'Papers';
      case ApprovalType.updatePaper:
        return 'Papers';
      case ApprovalType.addCourse:
        return 'Courses';
      case ApprovalType.addProfessor:
        return 'Professors';
    }
    return null;
  }
}

class UserType {
  static String admin = 'admin';
  static String user = 'user';
}

class Reviewable {
  dynamic item;
  List<String> likedBy = [];
  List<String> dislikedBy = [];
  Map<String, List<dynamic>> tags = {};
  InstanceType? reviewType;
}

enum InstanceType { course, professor }

extension InstanceTypeExtension on InstanceType {
  String getMetadataPath() {
    switch (this) {
      case InstanceType.course:
        return 'Metadata/CourseReviews';
      case InstanceType.professor:
        return 'Metadata/ProfessorReviews';
      default:
        return 'unhandled-case';
    }
  }
}

class Review implements Reviewable {
  dynamic item;
  List<String> likedBy = [];
  List<String> dislikedBy = [];
  Map<String, List<dynamic>> tags = {};
  InstanceType? reviewType;
  int likes, dislikes;
  late double percentage;
  Review({
    required instance,
    required this.likedBy,
    required this.dislikedBy,
    required this.tags,
    required this.reviewType,
  })  : item = reviewType == InstanceType.professor
            ? instance as p.Professor
            : instance as c.Course,
        likes = likedBy.length,
        dislikes = dislikedBy.length {
    percentage = (likes + dislikes) > 0 ? likes / (likes + dislikes) * 100 : 0;
  }

  @override
  String toString() {
    return 'Review{likedBy: $likedBy, dislikedBy: $dislikedBy, tags: $tags, reviewType: $reviewType}';
  }
}
