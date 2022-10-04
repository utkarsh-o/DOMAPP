import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../GlobalHelpers/GoogleDrive.dart';

Future<FilePickerResult> pickFile() async {
  final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'pptx', 'ppt', 'doc', 'docx']);
  if (file == null) {
    throw PickFileExceptions(ExceptionTypes.fileNotPicked);
  }
  return file;
}

Future<String> uploadFile(FilePickerResult file) async {
  final gd = GoogleDrive();
  final String? linkToFile =
      await gd.uploadFileToGoogleDrive(File(file.files.first.path!));
  if (linkToFile == null) {
    throw PickFileExceptions(ExceptionTypes.linkNotGenerated);
  }
  return linkToFile;
}

class PickFileExceptions implements Exception {
  String _message;
  PickFileExceptions(this._message);
  @override
  String toString() {
    return _message;
  }
}

class ExceptionTypes {
  //function signature for easier identification while debugging;
  static const String unhandled = 'Unhandled Exception';
  static const String fileNotPicked = 'File not Picked';
  static const String linkNotGenerated = 'Link to file not Generated';
}
