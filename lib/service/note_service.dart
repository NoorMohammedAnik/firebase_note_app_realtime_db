import 'package:firebase_database/firebase_database.dart';

import '../models/note.dart';

class NoteService {
  //connect to firebase database
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref('notes');

  //for getting all notes data from firebase database
  Stream<List<Note>> getNotes() {
    return dbReference.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return data.entries
          .map((entry) => Note.fromJson(Map<String, dynamic>.from(entry.value)))
          .toList();
    });
  }

  //for adding new note to firebase database
  Future addNote(Note note) async {
    final newNoteRef = dbReference.push();
    note.id = newNoteRef.key;
    await newNoteRef.set(note.toJson());
  }

  //for updating existing note in firebase database
  Future updateNote(Note note) async {
    if (note.id != null) {
      await dbReference.child(note.id!).set(note.toJson());
    }
  }

  //for deleting note from firebase database
  Future deleteNote(String noteId) async {
    await dbReference.child(noteId).remove();
  }
}
