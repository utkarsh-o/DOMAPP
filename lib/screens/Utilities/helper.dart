import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../HiveDB/User.dart';
import '../../cache/models.dart' as m;

updateTag({
  required String tag,
  required String path,
  required Map<String, List<String>> tags,
}) {
  final firestore = FirebaseFirestore.instance;
  final User user = Hive.box('global').get('user');
  if (tags[tag]!.contains(user.id)) {
    firestore.doc(path).update({
      'tags.$tag': FieldValue.arrayRemove([user.id]),
    });
    return;
  }
  firestore.doc(path).update({
    'tags.$tag': FieldValue.arrayUnion([user.id]),
  });
}

updateLikes({
  required List<String> likedBy,
  required String path,
}) {
  final firestore = FirebaseFirestore.instance;
  final User user = Hive.box('global').get('user');
  if (likedBy.contains(user.id)) {
    firestore.doc(path).update({
      'likedBy': FieldValue.arrayRemove([user.id]),
    });
    return;
  }
  firestore.doc(path).update({
    'likedBy': FieldValue.arrayUnion([user.id]),
  });
}

Future<List<String>> getTags({required m.InstanceType instanceType}) async {
  final firestore = FirebaseFirestore.instance;
  final metadataSnapshot =
      await firestore.doc(instanceType.getMetadataPath()).get();
  return metadataSnapshot.get('tags').cast<String>();
}

addTag({required String tag, required path}) async {
  final firestore = FirebaseFirestore.instance;
  final User user = Hive.box('global').get('user');
  firestore.doc(path).update({
    'tags.$tag': [user.id],
  });
}
