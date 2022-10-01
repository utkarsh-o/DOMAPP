import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domapp/screens/Utilities/selected_professor_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../HiveDB/Professor.dart';
import '../../cache/constants.dart';
import '../../cache/local_data.dart';
import '../../cache/models.dart' as m;
import '../Acads/helper/helper.dart';

List<Color> colorList = [kRed, kYellow, kGreen];
List<String> sortMethods = [
  'Rating',
  'Alphabetically',
  'Joining Year',
];
String? selectedBranch = branchList.first;
String? selectedSort = sortMethods.first;
TextEditingController filterController = TextEditingController();

class ProfDisplayMeta {
  Professor professor;
  int like, dislike;
  Map<String, int> tags = {};
  ProfDisplayMeta(
      {required this.professor, required this.like, required this.dislike});
  @override
  String toString() {
    return 'ProfDisplayMeta{professor: $professor, like: $like, dislike: $dislike, tags: $tags}';
  }
}

class ProfessorReviewPage extends StatefulWidget {
  static const String route = 'ProfessorReviewPage';

  @override
  _ProfessorReviewPageState createState() => _ProfessorReviewPageState();
}

class _ProfessorReviewPageState extends State<ProfessorReviewPage> {
  String query = '';
  List<m.Professor> filteredProfessors = professorList;
  final globalBox = Hive.box('global');
  late List<Professor> allProfessors;
  final reviews = ValueNotifier<List<m.Review>>([]);
  final isLoading = ValueNotifier<bool>(true);
  _getData() async {
    final firestore = FirebaseFirestore.instance;
    await getAllProfessors();
    allProfessors =
        await globalBox.get('professors', defaultValue: <Professor>[]);
    for (var _professor in allProfessors) {
      final profRef = await firestore.doc('Professors/${_professor.uid}').get();
      List<String> likedBy = profRef.get('likedBy').cast<String>();
      List<String> dislikedBy = profRef.get('dislikedBy').cast<String>();
      Map<String, List<dynamic>> tags =
          Map<String, List<dynamic>>.from(profRef.get('tags'));
      reviews.value.add(
        m.Review(
          reviewType: m.InstanceType.professor,
          instance: _professor,
          likedBy: likedBy,
          dislikedBy: dislikedBy,
          tags: tags,
        ),
      );
    }
    isLoading.value = false;
  }

  _ProfessorReviewPageState() {
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool _isLoading, _widget) {
              if (_isLoading)
                return Center(
                  child: CircularProgressIndicator(
                    color: kWhite,
                  ),
                );
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(context),
                      child: SvgPicture.asset(
                        'assets/icons/back_button_title_bar.svg',
                        color: kWhite,
                      ),
                    ),
                  ),
                  Text(
                    'Professor Review',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  SortFilterWrapper(onChanged: searchProfessor),
                  ValueListenableBuilder(
                    valueListenable: reviews,
                    builder: (context, List<m.Review> _reviews, _widget) {
                      return Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ProfessorListBuilder(
                                review: _reviews[index],
                                index: index,
                              );
                            },
                            itemCount: _reviews.length),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void searchProfessor(String query) {
    final result = professorList.where((professor) {
      final nameLower = professor.name.toLowerCase();
      final branchesLower = professor.branches.join(' ').toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          branchesLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.filteredProfessors = result;
    });
  }
}

class ProfessorListBuilder extends StatelessWidget {
  const ProfessorListBuilder({
    Key? key,
    required this.review,
    required this.index,
  }) : super(key: key);

  final m.Review review;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SelectedProfessorReviewPage(
          review: review,
        );
      })),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 10,
                color: colorList[index % 3],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      review.item.name,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                    Text(
                      review.item.branch,
                      style: TextStyle(fontSize: 12, color: kWhite),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(
                          'assets/icons/thumbs_up_filled.svg',
                          color: colorList[index % 3],
                        ),
                      ),
                      Text(
                        ' ${review.likes}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorList[index % 3]),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '${review.percentage.toStringAsFixed(2)} %',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   child:
                  //       SvgPicture.asset('assets/icons/thumbs_down_hollow.svg'),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SortFilterWrapper extends StatefulWidget {
  final ValueChanged<String> onChanged;
  SortFilterWrapper({required this.onChanged});
  @override
  _SortFilterWrapperState createState() => _SortFilterWrapperState();
}

class _SortFilterWrapperState extends State<SortFilterWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: kBlue.withOpacity(0.65),
                offset: Offset(0, 3),
                blurRadius: 1),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kColorBackgroundDark.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 1),
                  ],
                ),
                child: DropdownButton(
                  icon: SvgPicture.asset(
                    'assets/icons/expand_down.svg',
                  ),
                  iconSize: 20,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kColorBackgroundDark,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedSort,
                  items: sortMethods.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSort = value;
                    });
                  },
                  underline: Container(height: 0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kColorBackgroundDark.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 1),
                  ],
                ),
                child: DropdownButton(
                  icon: SvgPicture.asset(
                    'assets/icons/expand_down.svg',
                  ),
                  iconSize: 20,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kColorBackgroundDark,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedBranch,
                  items: branchList.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedBranch = value;
                    });
                  },
                  underline: Container(height: 0),
                ),
              ),
            ],
          ),
          Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kColorBackgroundDark.withOpacity(0.45),
                    blurRadius: 1,
                    offset: Offset(0, 4))
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                fillColor: kWhite,
                isDense: true,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                prefixIcon: Icon(
                  Icons.search,
                  color: kColorBackgroundDark,
                ),
                suffixIcon: filterController.text != ''
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: kColorBackgroundDark,
                        ),
                        onTap: () {
                          filterController.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search by name or branch',
                hintStyle: TextStyle(
                  color: kColorBackgroundDark.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: kColorBackgroundDark.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              onChanged: widget.onChanged,
            ),
          )
        ],
      ),
    );
  }
}
