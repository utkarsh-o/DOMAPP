import 'dart:io';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../cache/constants.dart';

// !!! Add 'domapp-45ddd-6dc12d568bca.json' to 'assets/keys/' !!!
// Generate this from service account keys section

// REFERENCE: https://stackoverflow.com/questions/65784077/how-do-i-upload-a-file-to-google-drive-using-flutter

// Fetch content from the json file
Future<dynamic> readJson() async {
  final String response =
      await rootBundle.loadString('assets/keys/domapp-45ddd-6dc12d568bca.json');
  final data = await json.decode(response);
  final serviceAccountCredentials =
      new ServiceAccountCredentials.fromJson(data);
  return serviceAccountCredentials;
}

const _scopes = ['https://www.googleapis.com/auth/drive.file'];

//TODO: change this var to AutoRefreshingAuthClient
var authClient;

class GoogleDrive {
  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    if (authClient == null) {
      // final serviceAccountCredentials = new ServiceAccountCredentials.fromJson({__JSON__HERE__});
      // Read credentials from assets
      final serviceAccountCredentials = await readJson();
      authClient =
          await clientViaServiceAccount(serviceAccountCredentials, _scopes);
    }
    return authClient;
  }

  Future<String?> uploadFileToGoogleDrive(File file) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);

    /*
      * Create folder from any google account
      * Permissions: View all
      * Give edit access to firebase-adminsdk-jd6l9@domapp-45ddd.iam.gserviceaccount.com
      * Paste folder ID here
      * All uploaded files will be in this folder
    */

    String folderId = FOLDER_ID;
    ga.File fileToUpload = ga.File();
    fileToUpload.parents = [folderId];
    fileToUpload.name = p.basename(file.absolute.path);
    var response = await drive.files.create(
      fileToUpload,
      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
    );

    if (response.id == null) {
      print("File upload failed!");
      return null;
    }
    String link = GDRIVE_LINK_PREFIX + response.id! + GDRIVE_LINK_POSTFIX;
    return link;
  }
}
