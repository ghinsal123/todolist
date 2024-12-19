import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskTitle;
  final String initialNote;

  const EditTaskScreen({
    super.key,
    required this.taskTitle,
    required this.initialNote,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Edit: ${widget.taskTitle}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Catatan Tugas:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: null, // Memungkinkan banyak baris
              decoration: InputDecoration(
                hintText: "Tulis catatan Anda di sini...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                if (_noteController.text.isNotEmpty) {
                  Navigator.of(context).pop(_noteController.text);
                }
              },
              child: const Text(
                "SIMPAN PERUBAHAN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
