import 'package:firebase_note_app_realtime_db/service/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/note.dart';

class UpdateNotes extends StatefulWidget {
  final Note? note;

  const UpdateNotes({super.key, this.note});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  //declare controller
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  //declare form key variable
  final GlobalKey<FormState> noteFormKey = GlobalKey();

  //declare services
  final NoteService noteService = NoteService();

  //for updating notes
  Future updateNote() async {
    final newNote = Note(
      id: widget.note!.id,
      name: nameController.text,
      description: descriptionController.text,
    );

    await noteService.updateNote(newNote);

    Get.back();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = widget.note!.name.toString();
    descriptionController.text = widget.note!.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          "Updates Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: noteFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter Description",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (noteFormKey.currentState!.validate()) {
                    noteFormKey.currentState!.save();

                    updateNote();
                  }
                },
                child: const Text(
                  "Update Notes",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
