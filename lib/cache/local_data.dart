import 'package:flutter/material.dart';

import 'constants.dart';
import 'models.dart';

List<Color> colourList = [kRed, kYellow, kGreen];

User user = getUserByUID(4);

String getAvatarByID(int avatarID, String gender) => gender == 'male'
    ? 'assets/avatars/male$avatarID.svg'
    : 'assets/avatars/female$avatarID.svg';

List<User> userList = [
  User(
    firstName: 'Pulkit',
    lastName: 'Agarwal',
    gender: 'male',
    avatarID: 1,
    UID: 1,
    userName: 'pkAgarwal',
  ),
  User(
    firstName: 'Vishal',
    lastName: 'Gupta',
    avatarID: 2,
    UID: 2,
    gender: 'male',
    userName: 'vsGupta',
  ),
  User(
    firstName: 'Akshat',
    lastName: 'Singh',
    avatarID: 1,
    UID: 3,
    gender: 'male',
    userName: 'akSingh',
  ),
  User(
    firstName: 'Vaani',
    lastName: 'Mishra',
    avatarID: 2,
    UID: 4,
    gender: 'female',
    userName: 'vnMishra',
  ),
];
User getUserByUID(int uid) =>
    userList.where((User user) => user.UID == uid).first;

List<Comment> commentList = [
  Comment(
    author: getUserByUID(2),
    likes: 4,
    text: 'They don’t wanna take the time and energy to do so',
  ),
  Comment(
    author: getUserByUID(4),
    likes: 1,
    text:
        'But it is not hygienic I mean you bring all the dirt from outside. doesn\'t make sense to me at all.',
  )
];

List<Post> postList = [
  Post(
    title: 'How are thoughts made ?',
    author: getUserByUID(2),
    dateCreated: DateTime.parse('2021-06-10'),
    tags: ['math', 'algebra', 'wtfIsThis'],
    likes: 11,
    comments: 16,
  ),
  Post(
    title: 'Why do people wear shoes in the house ?',
    author: getUserByUID(3),
    dateCreated: DateTime.parse('2021-06-16'),
    tags: ['ece', 'comSys', 'brainDead'],
    likes: 6,
    comments: 4,
  ),
  Post(
    title: 'Does anybody else just stare into the void ?',
    author: getUserByUID(1),
    dateCreated: DateTime.parse('2021-06-03'),
    tags: ['mech', 'hydraulics', 'notStupid'],
    likes: 12,
    comments: 9,
  ),
  Post(
    title: 'What is it like to be the fuckup in the family ?',
    author: getUserByUID(4),
    dateCreated: DateTime.parse('2021-06-03'),
    likes: 33,
    comments: 47,
    tags: ['CS', 'DSA', 'woke'],
  ),
];

List<Professor> professorList = [
  Professor(
      name: 'Michale Artin',
      branches: ['M.Sc. Math', 'B.E. CSE', 'M.Sc. Physics'],
      uid: '1'),
  Professor(
      name: 'Herman Chernoff',
      branches: ['M.Sc. Math', 'M.Sc. Physics'],
      uid: '2'),
  Professor(
      name: 'Bonnie Berger', branches: ['M.Sc. Math', 'B.E. CSE'], uid: '3'),
  Professor(
      name: 'Tristan Collins',
      branches: ['M.Sc. Math', 'M.Sc. Economics'],
      uid: '4'),
  Professor(
      name: 'Michale Artin',
      branches: ['M.Sc. Math', 'B.E. CSE', 'M.Sc. Physics'],
      uid: '5'),
  Professor(
      name: 'Herman Chernoff',
      branches: ['M.Sc. Math', 'M.Sc. Physics'],
      uid: '6'),
  Professor(
    name: 'Bonnie Berger',
    branches: ['M.Sc. Math', 'B.E. CSE'],
    uid: '7',
  ),
  Professor(
      name: 'Tristan Collins',
      branches: ['M.Sc. Math', 'M.Sc. Economics'],
      uid: '8'),
  Professor(
    name: 'Lakshmi Subramaniam',
    branches: ['Humanities'],
    uid: '9',
  ),
  Professor(
    name: 'Nilak Dutta',
    branches: ['Humanities'],
    uid: '10',
  ),
  Professor(
    name: 'R P Pradhan',
    branches: ['Humanities'],
    uid: '11',
  ),
  Professor(
    name: 'Rayson K. Alex',
    branches: ['Humanities'],
    uid: '12',
  ),
];

getProfessorByUID(String uid) {
  for (var prof in professorList) {
    if (prof.uid == uid) return prof;
  }
}

Course? getCourseByBranchandID({required Branch branch, required int id}) {
  for (var crs in courseList) {
    if (crs.branch == branch && crs.idNumber == id) return crs;
  }
}

String getBranchName(Branch branch) {
  switch (branch) {
    case Branch.Mathematics:
      return 'M.Sc. Math';
    case Branch.Humanities:
      return 'Humanities';
    case Branch.Chemical:
      return 'M.Sc. Chemical';
    case Branch.Electrical:
      return 'B.E. Electrical';
    case Branch.ElectronicsAndCommunication:
      return 'B.E. ECE';
    case Branch.ElectronicsAndInstrumentation:
      return 'B.E. ENI';
    case Branch.ComputerScience:
      return 'B.E. CSE';
    case Branch.Mechanical:
      return 'B.E. Mech';
    default:
      return 'invalid';
  }
}

List<Course> courseList = [
  Course(
    title: 'Main Trends In Indian History',
    professor: getProfessorByUID('9'),
    branch: Branch.Humanities,
    type: 'Elective',
    idNumber: 233,
  ),
  Course(
    title: 'Urban Modernity and Renewal of Paris',
    professor: getProfessorByUID('10'),
    branch: Branch.Humanities,
    idNumber: 374,
    type: 'Elective',
  ),
  Course(
    title: 'International Relations',
    professor: getProfessorByUID('11'),
    branch: Branch.Humanities,
    idNumber: 365,
    type: 'Elective',
  ),
  Course(
    title: 'Ecocriticism',
    professor: getProfessorByUID('12'),
    branch: Branch.Humanities,
    idNumber: 420,
    type: 'Elective',
  ),
  Course(
    title: 'Discrete Mathematics',
    professor: getProfessorByUID('1'),
    branch: Branch.Mathematics,
    idNumber: 213,
    type: 'CDC 2 - 1',
  ),
  Course(
    title: 'Mathematical Methods',
    professor: getProfessorByUID('2'),
    branch: Branch.Mathematics,
    idNumber: 241,
    type: 'CDC 2 - 2',
  ),
  Course(
    title: 'Graphs and Networks',
    professor: getProfessorByUID('3'),
    branch: Branch.Mathematics,
    idNumber: 234,
    type: 'CDC 2 - 2',
  ),
  Course(
    title: 'Statistical Inference',
    professor: getProfessorByUID('4'),
    branch: Branch.Mathematics,
    idNumber: 353,
    type: 'DEL',
  ),
  Course(
    title: 'Algebra 1',
    professor: getProfessorByUID('5'),
    branch: Branch.Mathematics,
    idNumber: 215,
    type: 'CDC 2 - 1',
  ),
  Course(
    title: 'Elementary Real Analysis',
    professor: getProfessorByUID('6'),
    branch: Branch.Mathematics,
    idNumber: 214,
    type: 'CDC 2 - 1',
  ),
];

List<Course?> pickedCourses = [
  getCourseByBranchandID(branch: Branch.Humanities, id: 233)
];

List<Tag> pickedTags1 = [
  Tag(
    title: 'Interesting',
    votes: 41,
  ),
  Tag(
    title: 'Scoring',
    votes: 33,
  ),
  Tag(
    title: 'Useful',
    votes: 30,
  ),
  Tag(
    title: 'Harder post midsem',
    votes: 22,
  ),
  Tag(
    title: 'Many applications in CS',
    votes: 18,
  ),
];

List<Tag> pickedTags2 = [
  Tag(
    title: 'Strict',
    votes: 41,
  ),
  Tag(
    title: 'Knowledgeable',
    votes: 33,
  ),
  Tag(
    title: 'Useful',
    votes: 30,
  ),
  Tag(
    title: 'Helpful',
    votes: 22,
  ),
];
