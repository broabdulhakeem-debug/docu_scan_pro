import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDocument({
    required String userId,
    required String fileName,
    required String downloadUrl,
    required String ocrText,
  }) async {
    await _db.collection('documents').add({
      'userId': userId,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'ocrText': ocrText,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserDocuments(String userId) {
    return _db
        .collection('documents')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> saveNote({
    required String documentId,
    required String userId,
    required String noteText,
    required Map<String, dynamic> position,
  }) async {
    await _db.collection('notes').add({
      'documentId': documentId,
      'userId': userId,
      'noteText': noteText,
      'position': position,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}