import 'package:firebase_note_app_realtime_db/add_notes.dart';
import 'package:firebase_note_app_realtime_db/service/note_service.dart';
import 'package:firebase_note_app_realtime_db/update_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<Note>>(
        stream: noteService.getNotes(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  title: Text(
                    note.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(note.description),
                  leading: const Icon(
                    Icons.note_alt_outlined,
                    size: 40,
                  ),
                  onTap: () {
                    Get.to(UpdateNotes(note: note));
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      noteService.deleteNote(note.id!);
                    } ,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(const AddNotes());
        },
      ),
    );
  }
}
