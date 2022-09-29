import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UploadFileServices {
  ///Upload Image to Storage
  Future<String> getUrl(BuildContext context, {required File file}) async {
    late String postFileUrl;
    try {
      print(file);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${file.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);
       uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("_______________________${progress}");
      });
      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((fileURL) {
          postFileUrl = fileURL;
        });
      });
      return postFileUrl;
    } on FirebaseException catch (e) {

      rethrow;
    }
  }
}
