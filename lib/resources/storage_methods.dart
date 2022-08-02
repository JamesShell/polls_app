import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Adding image to firebase storage
  Future<List<String>> uploadImageToStorage(
      String childName, List<Uint8List> files, bool isPoll) async {
    Reference ref = _storage.ref().child(_auth.currentUser!.uid);

    if (isPoll) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    List<String> out = [];
    for (int f = 0; f < files.length; f++) {
      UploadTask uploadTask = ref.child("$f").putData(files[f]);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      out.add(downloadUrl);
    }

    return out;
  }
}
