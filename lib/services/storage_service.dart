import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<String> uploadDocument(File file, String userId) async {
    final String fileId = _uuid.v4();
    final Reference ref = _storage.ref().child('documents/$userId/$fileId.jpg');

    final UploadTask uploadTask = ref.putFile(file);
    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadPDF(File file, String userId) async {
    final String fileId = _uuid.v4();
    final Reference ref = _storage.ref().child('pdfs/$userId/$fileId.pdf');

    final UploadTask uploadTask = ref.putFile(file);
    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}