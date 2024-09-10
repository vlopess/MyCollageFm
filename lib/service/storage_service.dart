import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';

final firebaseStorageRepository = Provider(
  (ref) => FirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance
  )
);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async { 
    try {
      UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteFileToFirebase(String imageUrl)async { 
    try {      
      final desertRef = firebaseStorage.ref().child(imageUrl);
      await desertRef.delete();
      
    } catch (e) {
      rethrow;
    }
  }
}