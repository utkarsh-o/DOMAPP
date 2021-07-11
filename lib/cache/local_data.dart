class Professor {
  String name;
  List<String> branches;
  Professor({required this.name, required this.branches});
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

List<Comment> commentList = [
  Comment(
      authorName: 'Vishal Gupta',
      likes: 4,
      text: 'They don’t wanna take the time and energy to do so',
      authorUsername: '@vsGupta',
      authorGender: 'male'),
  Comment(
      authorName: 'Vaani Mishra',
      likes: 1,
      text:
          'But it is not hygienic I mean you bring all the dirt from outside. doesn\'t make sense to me at all.',
      authorUsername: '@vnMishra',
      authorGender: 'female')
];

List<Post> postList = [
  Post(
    title: 'How are thoughts made ?',
    authorName: 'Vishal Gupta',
    dateCreated: DateTime.parse('2021-06-10'),
    tags: ['math', 'algebra', 'wtfIsThis'],
    likes: 11,
    comments: 16,
  ),
  Post(
    title: 'Why do people wear shoes in the house ?',
    authorName: 'Akshat Singh',
    dateCreated: DateTime.parse('2021-06-16'),
    tags: ['ece', 'comSys', 'brainDead'],
    likes: 6,
    comments: 4,
  ),
  Post(
    title: 'Does anybody else just stare into the void ?',
    authorName: 'Pulkit Agarwal',
    dateCreated: DateTime.parse('2021-06-03'),
    tags: ['mech', 'hydraulics', 'notStupid'],
    likes: 12,
    comments: 9,
  ),
  Post(
    title: 'What is it like to be the fuckup in the family ?',
    authorName: 'Vaani Mishra',
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
  ),
  Professor(
    name: 'Herman Chernoff',
    branches: ['M.Sc. Math', 'M.Sc. Physics'],
  ),
  Professor(
    name: 'Bonnie Berger',
    branches: ['M.Sc. Math', 'B.E. CSE'],
  ),
  Professor(
    name: 'Tristan Collins',
    branches: ['M.Sc. Math', 'M.Sc. Economics'],
  ),
  Professor(
    name: 'Michale Artin',
    branches: ['M.Sc. Math', 'B.E. CSE', 'M.Sc. Physics'],
  ),
  Professor(
    name: 'Herman Chernoff',
    branches: ['M.Sc. Math', 'M.Sc. Physics'],
  ),
  Professor(
    name: 'Bonnie Berger',
    branches: ['M.Sc. Math', 'B.E. CSE'],
  ),
  Professor(
    name: 'Tristan Collins',
    branches: ['M.Sc. Math', 'M.Sc. Economics'],
  ),
];
