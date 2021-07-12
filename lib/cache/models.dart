class Professor {
  String name, uid;
  List<String> branches;
  Professor({required this.name, required this.branches, required this.uid});
}

class Post {
  String title, authorName;
  List<String> tags;
  DateTime dateCreated;
  int likes, comments;
  Post({
    required this.title,
    required this.authorName,
    required this.dateCreated,
    required this.tags,
    required this.likes,
    required this.comments,
  });
}

class Comment {
  String authorName, authorUsername, text, authorGender;
  int likes;
  Comment(
      {required this.authorName,
      required this.likes,
      required this.text,
      required this.authorUsername,
      required this.authorGender});
}

class User {
  String firstName, lastName, userName;
  User(
      {required this.firstName,
      required this.lastName,
      required this.userName});
  String get fullName => '$firstName $lastName';
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
