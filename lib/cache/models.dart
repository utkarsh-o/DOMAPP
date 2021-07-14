import 'package:domapp/cache/local_data.dart';

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

enum Branch {
  ComputerScience,
  Humanities,
  Mathematics,
  Mechanical,
  Chemical,
  ElectronicsAndInstrumentation,
  Electrical,
  ElectronicsAndCommunication
}

class Course {
  Professor professor;
  String title, type;
  Branch branch;
  int idNumber;
  Course(
      {required this.title,
      required this.idNumber,
      required this.branch,
      required this.professor,
      required this.type});
  String getBranchName() {
    switch (branch) {
      case Branch.Humanities:
        return 'Humanities';
      default:
        return 'Unknown';
    }
  }

  String getIDName() {
    switch (branch) {
      case Branch.Humanities:
        return 'HSS';
      default:
        return 'unknown';
    }
  }
}

class Tag {
  String title;
  int votes;
  Tag({required this.title, required this.votes});
}
