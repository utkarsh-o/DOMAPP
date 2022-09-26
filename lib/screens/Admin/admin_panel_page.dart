import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domapp/screens/Admin/add_course_page.dart';
import 'package:domapp/screens/Admin/add_professor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../HiveDB/Approval.dart';
import '../../HiveDB/User.dart' as u;
import '../../cache/constants.dart';
import '../../cache/models.dart';
import '../../cache/local_data.dart';
import '../Utilities/course_review_page.dart';
import 'helpers.dart';

class AdminPanelPage extends StatefulWidget {
  static const String route = 'AdminPanelPage';

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  late Stream<List<Approval>> approvalStream;
  Future<Approval> generateApproval(snapshot) async {
    final userReference = snapshot['user'];
    final userSnapshot =
        await FirebaseFirestore.instance.doc('Users/$userReference').get();
    final user = u.User.fromJSON(userSnapshot);
    await updateAdminCount();
    return Approval.fromJson(snapshot, user);
  }

  @override
  void initState() {
    approvalStream = FirebaseFirestore.instance
        .collection('Approvals')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return Future.wait(
          [for (var snpst in snapshot.docs) generateApproval(snpst)]);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_button_title_bar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AddProfessorPage.route),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: kRed.withOpacity(0.65),
                            blurRadius: 1,
                            offset: Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/professor.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Add Professor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kColorBackgroundDark.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, AddCoursePage.route),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: kYellow.withOpacity(0.65),
                            blurRadius: 1,
                            offset: Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/course.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Add Course',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kColorBackgroundDark.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, CourseReviewPage.route),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: kGreen,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: kGreen.withOpacity(0.65),
                            blurRadius: 1,
                            offset: Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/timetable.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Raise a Ticket',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kColorBackgroundDark.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Approve Actions ',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: approvalStream,
                builder: (context, AsyncSnapshot<List<Approval>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kWhite,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AdminApprovalListBuilder(
                            approval: snapshot.data![index],
                            index: index,
                          );
                        },
                        itemCount: snapshot.data!.length),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdminApprovalListBuilder extends StatelessWidget {
  final Approval approval;
  final int index;
  late final numApprovals;
  late final numRejects;
  AdminApprovalListBuilder({required this.approval, required this.index})
      : numApprovals = ValueNotifier(approval.accepts),
        numRejects = ValueNotifier(approval.rejects);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      // onTap: () => Navigator.pushNamed(context, SelectedCourseReviewPage.route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 10,
                color: colourList[index % 3],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      approval.description,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        approval.user.type == UserType.admin
                            ? SvgPicture.asset('assets/icons/admin.svg',
                                height: 15)
                            : SvgPicture.asset('assets/icons/member.svg',
                                height: 15),
                        SizedBox(width: 8),
                        Text(
                          approval.user.name,
                          style: TextStyle(fontSize: 12, color: kWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await updateAcceptsRejects(
                        approval: approval,
                        approvalUpdateType: ApprovalUpdateType.rejects,
                        updatedValue: approval.rejects + 1,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                              color: kWhite.withOpacity(0.45),
                              offset: Offset(0, 4),
                              blurRadius: 1),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            approval.alreadyRejected
                                ? Icons.dangerous_rounded
                                : Icons.dangerous_outlined,
                            color: kRed,
                            size: 20,
                          ),
                          // SvgPicture.asset(
                          //   'assets/icons/report_filled.svg',
                          //   color: kRed,
                          //   height: 20,
                          // ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            approval.rejects.toString(),
                            style: TextStyle(
                                color: kRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      await updateAcceptsRejects(
                        approval: approval,
                        approvalUpdateType: ApprovalUpdateType.accepts,
                        updatedValue: approval.accepts + 1,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                              color: kWhite.withOpacity(0.45),
                              offset: Offset(0, 4),
                              blurRadius: 1),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            approval.alreadyAccepted
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: kGreen,
                            size: 20,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            approval.accepts.toString(),
                            style: TextStyle(
                                color: kGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
