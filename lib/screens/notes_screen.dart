import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class NotesScreen extends StatefulWidget {
  final String documentId;
  final String userId;

  const NotesScreen({
    super.key,
    required this.documentId,
    required this.userId,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController noteController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  Map<String, dynamic> position = {
    'x': 0.0,
    'y': 0.0,
  };

  Future<void> saveNote() async {
    if (noteController.text.isEmpty) return;

    await _firestoreService.saveNote(
      documentId: widget.documentId,
      userId: widget.userId,
      noteText: noteController.text,
      position: position,
    );

    noteController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('Tap on document area to set note position'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    labelText: 'Enter note',
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveNote,
                    child: const Text('Save Note'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}