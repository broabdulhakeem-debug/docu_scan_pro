import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class DocumentsScreen extends StatelessWidget {
  final String userId;

  DocumentsScreen({super.key, required this.userId});

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Documents'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getUserDocuments(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No documents found'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: Text(data['fileName'] ?? 'Untitled'),
                  subtitle: Text(
                    data['ocrText'] != null
                        ? data['ocrText'].toString().substring(0, data['ocrText'].toString().length > 50 ? 50 : data['ocrText'].toString().length)
                        : 'No text extracted',
                  ),
                  onTap: () {
                    // Future: open document viewer + annotations
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}