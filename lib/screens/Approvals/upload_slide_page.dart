import 'package:domapp/cache/models.dart';
import 'package:domapp/components/custom_snack_bar.dart';
import 'package:domapp/screens/Approvals/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../HiveDB/Slide.dart';
import '../../cache/constants.dart';
import '../../HiveDB/Course.dart' as c;
import '../../HiveDB/Professor.dart' as p;
import '../Acads/helper/helper.dart';

class UploadSlidePage extends StatelessWidget {
  static const String route = 'UploadSlidePage';
  final c.Course? course;
  UploadSlidePage({Key? key, this.course}) {
    professors = Hive.box('global')
        .get('professors', defaultValue: <p.Professor>[]).cast<p.Professor>();
    selectedProfessor = ValueNotifier<p.Professor>(professors.first);
  }
  final titleController = TextEditingController();
  final slideNoController = TextEditingController();
  final sectionController = TextEditingController();
  final selectedType = ValueNotifier<String>(SlideType.lecture);
  final selectedSession = ValueNotifier<Session>(Session.sessions.last);
  final _titleKey = GlobalKey<FormState>();
  final _slideNoKey = GlobalKey<FormState>();
  final _sectionKey = GlobalKey<FormState>();
  late List<p.Professor> professors;
  late ValueNotifier<p.Professor> selectedProfessor;
  final fileName = ValueNotifier<String?>(null);
  String pdfUrl = '';
  FilePickerResult? file;
  pickPDF() async {
    try {
      file = await pickFile();
      fileName.value = file!.files.first.name;
    } on PickFileExceptions catch (e, stackTrace) {
      String message = e.toString();
      switch (message) {
        case ExceptionTypes.fileNotPicked:
          message = 'Please pick a valid file';
          break;
      }
      showCustomSnackBar(text: message, color: kRed);
      print(e);
      print(stackTrace.toString());
    } catch (e, stackTrace) {
      print(ExceptionTypes.unhandled + e.toString());
      print(stackTrace.toString());
    }
  }

  createSlideHelper() async {
    try {
      if (!_titleKey.currentState!.validate() ||
          !_slideNoKey.currentState!.validate() ||
          !_sectionKey.currentState!.validate()) return;
      if (file == null) {
        showCustomSnackBar(text: 'Please select a the file');
        return;
      }
      pdfUrl = await uploadFile(file!);
      final slide = Slide(
          url: pdfUrl,
          date: selectedSession.value.date,
          sem: selectedSession.value.sem,
          section: int.parse(sectionController.value.text),
          course: course!,
          professor: selectedProfessor.value,
          slideType: selectedType.value,
          number: int.parse(slideNoController.value.text),
          title: titleController.text,
          uid: '');
      await createSlideApproval(slide: slide);
      print('createSlideHelper passed');
    } on PickFileExceptions catch (e, stackTrace) {
      String message = e.toString();
      switch (message) {
        case ExceptionTypes.linkNotGenerated:
          message =
              'Unable to upload the file, please try again or pick another file to continue';
          break;
      }
      showCustomSnackBar(text: message, color: kRed);
      print(e);
      print(stackTrace.toString());
    } catch (e, stackTrace) {
      print(ExceptionTypes.unhandled + e.toString());
      print(stackTrace.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_button_title_bar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
                Text(
                  'Upload Slide',
                  style: TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Title',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: kInactiveText,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      course!.name,
                      style: TextStyle(
                          fontSize: 30,
                          color: kWhite.withOpacity(0.8),
                          fontFamily: 'Satisfy'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slide Title',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: kInactiveText,
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Form(
                        key: _titleKey,
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: titleController,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kWhite,
                          ),
                          // controller: courseTitleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                            fillColor: Color(0XFF1D1C23),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: kGrey,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: kGrey,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintText: 'How to raise a buffalo',
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: kInactiveText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SlideNoField(
                      formKey: _slideNoKey,
                      title: 'Slide No',
                      controller: slideNoController,
                      hintText: 33,
                    ),
                    SlideNoField(
                      formKey: _sectionKey,
                      title: 'Section',
                      controller: sectionController,
                      hintText: 33,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Slide Type',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: kInactiveText,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.4,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 2,
                              color: kGrey,
                            ),
                            color: Color(0XFF1D1C23),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ValueListenableBuilder(
                              valueListenable: selectedType,
                              builder: (context, String value, widget) {
                                return DropdownButton(
                                  dropdownColor: kColorBackgroundDark,
                                  icon: SvgPicture.asset(
                                    'assets/icons/expand_down.svg',
                                    color: kWhite,
                                  ),
                                  iconSize: 20,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kWhite,
                                  ),
                                  isExpanded: true,
                                  isDense: true,
                                  value: selectedType.value,
                                  items:
                                      SlideType.slideTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      child: Text(
                                        value,
                                      ),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (String? value) =>
                                      selectedType.value = value!,
                                  underline: Container(
                                    height: 0,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ProfessorWrapper(
                  professors: professors,
                  selectedProfessor: selectedProfessor,
                ),
                SizedBox(height: 10),
                SessionUploadButtonWrapper(
                  selectedSession: selectedSession,
                  pickFileCallback: pickPDF,
                ),
                SizedBox(height: 20),
                PickedFileProgressBarWrapper(progress: 0.4, fileName: fileName),
                ConfirmButtonWrapper(callback: createSlideHelper),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SlideNoField extends StatelessWidget {
  final controller, hintText, title, formKey;
  SlideNoField(
      {required this.controller,
      this.hintText,
      required this.title,
      required this.formKey});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: kInactiveText,
          ),
        ),
        Container(
          width: size.width * 0.1,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Form(
            key: formKey,
            child: TextFormField(
              cursorColor: kWhite,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kWhite,
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
              controller: controller,
              maxLength: 3,
              decoration: InputDecoration(
                  errorStyle: TextStyle(
                    height: 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  counterText: '',
                  fillColor: Color(0XFF1D1C23),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: kGrey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: kGrey,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: hintText.toString(),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kInactiveText,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class PickedFileProgressBarWrapper extends StatelessWidget {
  const PickedFileProgressBarWrapper({
    Key? key,
    required this.progress,
    required this.fileName,
  }) : super(key: key);

  final double progress;
  final ValueNotifier<String?> fileName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final progressBarWidth = size.width * 0.5;

    return ValueListenableBuilder(
        valueListenable: fileName,
        builder: (context, String? _fileName, _widget) {
          if (_fileName == null) {
            return SizedBox();
          }
          return Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/icons/pdf.svg',
                    color: kWhite,
                    height: 20,
                  ),
                  SizedBox(width: 25),
                  SizedBox(
                    width: progressBarWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kWhite,
                            fontSize: 16,
                          ),
                        ),
                        // SizedBox(height: 10),
                        // Stack(
                        //   clipBehavior: Clip.none,
                        //   children: [
                        //     Visibility(
                        //       visible: progress < 1,
                        //       child: Positioned(
                        //         right: -60,
                        //         top: -7,
                        //         child: Text(
                        //           '${(progress * 100).toStringAsFixed(1)}%',
                        //           style: TextStyle(
                        //             color: kWhite,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       width: progressBarWidth * progress,
                        //       decoration: BoxDecoration(
                        //           border: Border.all(
                        //               color: progress == 1 ? kGreen : kWhite,
                        //               width: 2),
                        //           borderRadius: BorderRadius.circular(10)),
                        //     ),
                        //     SizedBox(width: 5),
                        //   ],
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class PickPDFButton extends StatelessWidget {
  final VoidCallback callback;
  PickPDFButton({required this.callback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => callback(),
        child: Container(
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 1),
              ]),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/upload.svg',
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.015),
              Text(
                'Pick PDF',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SessionUploadButtonWrapper extends StatelessWidget {
  final sessionList = Session.sessions;
  final selectedSession;
  final VoidCallback pickFileCallback;
  SessionUploadButtonWrapper(
      {Key? key, required this.selectedSession, required this.pickFileCallback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Session',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: kInactiveText,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.4,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: kGrey,
                  ),
                  color: Color(0XFF1D1C23),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ValueListenableBuilder(
                    valueListenable: selectedSession,
                    builder: (context, Session session, _widget) {
                      return DropdownButton<Session>(
                        dropdownColor: kColorBackgroundDark,
                        icon: SvgPicture.asset(
                          'assets/icons/expand_down.svg',
                          color: kWhite,
                        ),
                        iconSize: 20,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kWhite,
                        ),
                        isExpanded: true,
                        isDense: true,
                        value: session,
                        items: sessionList.reversed
                            .toList()
                            .map(
                              (Session value) => DropdownMenuItem<Session>(
                                child: Text(
                                  value.toString(),
                                ),
                                value: value,
                              ),
                            )
                            .toList(),
                        onChanged: (Session? ssn) =>
                            selectedSession.value = ssn,
                        underline: Container(
                          height: 0,
                        ),
                      );
                    }),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.1),
          PickPDFButton(callback: pickFileCallback),
        ],
      ),
    );
  }
}

class ConfirmButtonWrapper extends StatelessWidget {
  final VoidCallback callback;

  const ConfirmButtonWrapper({Key? key, required this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   width: size.width * 0.8,
          //   decoration: BoxDecoration(
          //       color: kWhite.withOpacity(0.2),
          //       borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(10),
          //           topLeft: Radius.circular(10))),
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(6),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(7),
          //           color: kWhite,
          //           boxShadow: [
          //             BoxShadow(
          //                 color: kWhite.withOpacity(0.45),
          //                 offset: Offset(0, 4),
          //                 blurRadius: 1),
          //           ],
          //         ),
          //         child: SvgPicture.asset(
          //           'assets/icons/verify_filled.svg',
          //           color: kColorBackgroundDark.withOpacity(0.8),
          //           height: 20,
          //         ),
          //       ),
          //       SizedBox(width: 16),
          //       Container(
          //         child: Flexible(
          //           child: Text(
          //             uploadDisclaimer,
          //             style: TextStyle(fontSize: 11, color: kWhite),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          InkWell(
            onTap: () => callback(),
            child: Container(
              // margin: EdgeInsets.only(bottom: size.height * 0.1),
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kWhite.withOpacity(0.55),
                    blurRadius: 1,
                    offset: Offset(0, 4),
                  )
                ],
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: kColorBackgroundDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfessorWrapper extends StatelessWidget {
  final List<p.Professor> professors;
  final ValueNotifier<p.Professor> selectedProfessor;
  const ProfessorWrapper(
      {Key? key, required this.professors, required this.selectedProfessor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.9,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: kGrey,
              ),
              color: Color(0XFF1D1C23),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ValueListenableBuilder(
                valueListenable: selectedProfessor,
                builder: (context, p.Professor selectedProf, _widget) {
                  return DropdownButton(
                    dropdownColor: kColorBackgroundDark,
                    icon: SvgPicture.asset(
                      'assets/icons/expand_down.svg',
                      color: kWhite,
                    ),
                    iconSize: 20,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                    ),
                    isExpanded: true,
                    isDense: true,
                    value: selectedProfessor.value,
                    items: professors.map((p.Professor prof) {
                      return DropdownMenuItem<p.Professor>(
                        child: Text(
                          prof.name,
                        ),
                        value: prof,
                      );
                    }).toList(),
                    onChanged: (p.Professor? prof) {
                      selectedProfessor.value = prof!;
                    },
                    underline: Container(
                      height: 0,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
