import 'dart:async';

import 'package:domapp/HiveDB/Paper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../HiveDB/Course.dart';
import '../../HiveDB/Professor.dart';
import '../../cache/constants.dart';
import '../../cache/models.dart' as m;
import '../../components/custom_snack_bar.dart';
import '../Acads/helper/helper.dart';
import 'helpers.dart';

DateTime pickedDate = DateTime.now();

class UploadQuestionPaperPage extends StatefulWidget {
  static const String route = 'UploadQuestionPaper';
  final Course? course;

  const UploadQuestionPaperPage({Key? key, this.course}) : super(key: key);
  @override
  _UploadQuestionPaperPageState createState() =>
      _UploadQuestionPaperPageState();
}

class _UploadQuestionPaperPageState extends State<UploadQuestionPaperPage> {
  late List<Professor> professors;
  late ValueNotifier<Professor> selectedProfessor;
  final ValueNotifier<String> selectedPaperType =
      ValueNotifier<String>(m.PaperType.paperTypes.first);
  final selectedSession = ValueNotifier<m.Session>(m.Session.sessions.last);
  final averageController = TextEditingController();
  final totalController = TextEditingController();
  final highestController = TextEditingController();
  final _averageKey = GlobalKey<FormState>();
  final _highestKey = GlobalKey<FormState>();
  final _totalKey = GlobalKey<FormState>();
  final declaration = ValueNotifier<bool>(false);

  _UploadQuestionPaperPageState() {
    professors = Hive.box('global')
        .get('professors', defaultValue: <Professor>[]).cast<Professor>();
    selectedProfessor = ValueNotifier<Professor>(professors.first);
  }
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

  createPaperHelper() async {
    try {
      if (!_averageKey.currentState!.validate() ||
          !_highestKey.currentState!.validate() ||
          !_totalKey.currentState!.validate()) return;
      if (file == null) {
        showCustomSnackBar(text: 'Please select a the file');
        return;
      }
      if (!declaration.value) {
        showCustomSnackBar(text: 'Please confirm declaration check');
        return;
      }
      pdfUrl = await uploadFile(file!);
      final paper = Paper(
        paperUrl: pdfUrl,
        sem: selectedSession.value.sem,
        course: widget.course!,
        professor: selectedProfessor.value,
        paperType: selectedPaperType.value,
        solutionUrl: 'solutionUrl',
        date: selectedSession.value.date,
        uid: '',
        average: int.parse(averageController.text.toString()),
        highest: int.parse(highestController.text.toString()),
        total: int.parse(
          totalController.text.toString(),
        ),
      );
      await createPaperApproval(paper: paper);
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

  Timer? _timer;
  int progress = 0;
  void startTimer() {
    progress = 0;
    const oneSec = const Duration(milliseconds: 100);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (progress == 100) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            progress++;
          });
        }
      },
    );
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
                  'Upload Question Paper',
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
                      widget.course!.name,
                      style: TextStyle(
                          fontSize: 30,
                          color: kWhite.withOpacity(0.8),
                          fontFamily: 'Satisfy'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SessionProfessorWrapper(
                  selectedSession: selectedSession,
                  professors: professors,
                  selectedProfessor: selectedProfessor,
                ),
                TypeAvTotHighestWrapper(
                  selectedPaperType: selectedPaperType,
                  averageController: averageController,
                  totalController: totalController,
                  highestController: highestController,
                  totalKey: _totalKey,
                  averageKey: _averageKey,
                  highestKey: _highestKey,
                ),
                // SizedBox(height: 20),
                PickPDFButton(
                  callback: pickPDF,
                ),
                SizedBox(height: 20),
                PickedFileProgressBarWrapper(
                    progress: progress / 100.toDouble(), fileName: fileName),
                ConfirmButtonWrapper(
                    callback: createPaperHelper, declaration: declaration),
              ],
            ),
          ),
        ),
      ),
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

class ConfirmButtonWrapper extends StatelessWidget {
  final VoidCallback callback;
  final ValueNotifier<bool> declaration;

  const ConfirmButtonWrapper(
      {Key? key, required this.callback, required this.declaration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: size.width * 0.8,
            decoration: BoxDecoration(
                color: kWhite.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: declaration,
                  builder: (context, bool confirmed, _widget) {
                    return InkWell(
                      onTap: () => declaration.value = !declaration.value,
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
                        child: SvgPicture.asset(
                          confirmed
                              ? 'assets/icons/verify_filled.svg'
                              : 'assets/icons/verify_hollow.svg',
                          color: kColorBackgroundDark.withOpacity(0.8),
                          height: 20,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 16),
                Container(
                  child: Flexible(
                    child: Text(
                      uploadDisclaimer,
                      style: TextStyle(fontSize: 11, color: kWhite),
                    ),
                  ),
                )
              ],
            ),
          ),
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
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
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

class PickPDFButton extends StatelessWidget {
  VoidCallback callback;
  PickPDFButton({required this.callback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: callback,
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

class TypeAvTotHighestWrapper extends StatelessWidget {
  final selectedPaperType;
  final List<String> paperTypes = m.PaperType.paperTypes;
  final averageController;
  final totalController;
  final highestController;
  final averageKey, highestKey, totalKey;
  TypeAvTotHighestWrapper({
    // Key? key,
    required this.selectedPaperType,
    required this.averageController,
    required this.totalController,
    required this.highestController,
    required this.averageKey,
    required this.highestKey,
    required this.totalKey,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void datePicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (date != null) {}
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // DatePicker(callback: datePicker),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Type',
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
                    color: Color(0XFF413F49),
                  ),
                  color: Color(0XFF1D1C23),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ValueListenableBuilder(
                    valueListenable: selectedPaperType,
                    builder: (context, String _selectedPaperType, _widget) {
                      return DropdownButton<String>(
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
                        value: selectedPaperType.value,
                        items: paperTypes.map((String paperType) {
                          return DropdownMenuItem<String>(
                            child: Text(paperType),
                            value: paperType,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          selectedPaperType.value = value!;
                        },
                        underline: Container(
                          height: 0,
                        ),
                      );
                    }),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Av/Total/Highest',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: kInactiveText,
                ),
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvTotalHighestTextField(
                      controller: averageController,
                      testKey: averageKey,
                      hintText: 33,
                    ),
                    AvTotalHighestTextField(
                      controller: highestController,
                      testKey: highestKey,
                      hintText: 51,
                    ),
                    AvTotalHighestTextField(
                      controller: totalController,
                      testKey: totalKey,
                      hintText: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvTotalHighestTextField extends StatelessWidget {
  final controller, hintText, testKey;
  AvTotalHighestTextField(
      {required this.controller, required this.testKey, this.hintText});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.1,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Form(
        key: testKey,
        child: TextFormField(
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: kWhite,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: controller,
          maxLength: 3,
          cursorColor: kWhite,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: kBlue,
                width: 2.0,
              ),
            ),
            errorStyle: TextStyle(
              height: 0,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
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
                color: Color(0XFF413F49),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: kBlue,
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText.toString(),
            hintStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final VoidCallback callback;
  DatePicker({required this.callback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
          InkWell(
            onTap: callback,
            child: Container(
              alignment: Alignment.center,
              // width: size.width * 0.4,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: Color(0XFF413F49),
                ),
                color: Color(0XFF1D1C23),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                DateFormat('EEE, MMM d').format(pickedDate),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kWhite,
                  // fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SessionProfessorWrapper extends StatelessWidget {
  late List<Professor> professors;
  late ValueNotifier<Professor> selectedProfessor;
  final sessionList = m.Session.sessions;
  final selectedSession;
  SessionProfessorWrapper(
      {required this.selectedSession,
      required this.professors,
      required this.selectedProfessor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  color: Color(0XFF413F49),
                ),
                color: Color(0XFF1D1C23),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ValueListenableBuilder(
                  valueListenable: selectedSession,
                  builder: (context, m.Session session, _widget) {
                    return DropdownButton<m.Session>(
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
                            (m.Session value) => DropdownMenuItem<m.Session>(
                              child: Text(
                                value.toString(),
                              ),
                              value: value,
                            ),
                          )
                          .toList(),
                      onChanged: (m.Session? ssn) =>
                          selectedSession.value = ssn,
                      underline: Container(
                        height: 0,
                      ),
                    );
                  }),
            ),
          ],
        ),
        ProfessorWrapper(
          professors: professors,
          selectedProfessor: selectedProfessor,
        ),
      ],
    );
  }
}

class ProfessorWrapper extends StatelessWidget {
  final List<Professor> professors;
  final ValueNotifier<Professor> selectedProfessor;
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
            width: size.width * 0.4,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: Color(0XFF413F49),
              ),
              color: Color(0XFF1D1C23),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ValueListenableBuilder(
                valueListenable: selectedProfessor,
                builder: (context, Professor selectedProf, _widget) {
                  return DropdownButton(
                    dropdownColor: kColorBackgroundDark,
                    icon: SvgPicture.asset(
                      'assets/icons/expand_down.svg',
                      color: kWhite,
                    ),
                    iconSize: 20,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                    ),
                    isExpanded: true,
                    isDense: true,
                    value: selectedProfessor.value,
                    items: professors.map((Professor prof) {
                      return DropdownMenuItem<Professor>(
                        child: Text(
                          prof.name,
                        ),
                        value: prof,
                      );
                    }).toList(),
                    onChanged: (Professor? prof) {
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
