import 'package:flutter/material.dart';
import 'package:todolistsatoernus/pages/edit.dart';
import 'package:todolistsatoernus/pages/logout.dart';
import 'package:todolistsatoernus/pages/profile.dart';
import 'package:todolistsatoernus/pages/time.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, String>> _tasks =
      []; // List untuk menyimpan tugas dan catatan

  // Fungsi untuk menampilkan dialog input
  void _showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Tugas Baru"),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: "Masukkan judul tugas",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("BATAL"),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  setState(() {
                    _tasks.add({
                      "title": taskController.text,
                      "note": ""
                    }); // Tambahkan tugas baru
                  });
                }
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("OKE"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus tugas
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Hapus tugas dari daftar
    });
  }

  // Navigasi ke halaman detail tugas
  void _openTaskDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(
          taskIndex: index,
          taskTitle: _tasks[index]["title"]!,
          taskNote: _tasks[index]["note"]!,
          onUpdate: (updatedNote) {
            setState(() {
              _tasks[index]["note"] = updatedNote; // Perbarui catatan
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
  backgroundColor: Colors.blue.shade900,
  automaticallyImplyLeading: false,
  title: Row(
    children: [
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, color: Colors.blue.shade900),
      ),
      const SizedBox(width: 10),
      const Text(
        "User0880",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(), // Memberi jarak otomatis di antara elemen
      PopupMenuButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onSelected: (value) {
          if (value == 'calendar') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TimeScreen()),
            );
          } else if (value == 'edit_profile') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          } else if (value == 'logout') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogoutScreen()),
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'calendar',
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.blue),
                SizedBox(width: 8),
                Text("Kalender"),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'edit_profile',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                SizedBox(width: 8),
                Text("Edit Profile"),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text("Logout"),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
),



      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "Category Tugas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // List of Tasks
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada tugas, tekan tombol + untuk menambahkan.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              _tasks[index]["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () async {
                                    final updatedNote = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditTaskScreen(
                                          taskTitle: _tasks[index]["title"]!,
                                          initialNote: _tasks[index]["note"]!,
                                        ),
                                      ),
                                    );
                                    if (updatedNote != null) {
                                      setState(() {
                                        _tasks[index]["note"] = updatedNote;
                                      });
                                    }
                                  },
                                ),
                                PopupMenuButton(
                                  color:
                                      Colors.blue.shade900, // Warna latar menu
                                  onSelected: (value) {
                                    if (value == 'delete') {
                                      _deleteTask(index);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        "Hapus",
                                        style: TextStyle(
                                            color: Colors
                                                .white), // Ubah teks menjadi putih
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () => _openTaskDetail(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _showAddTaskDialog,
      ),
    );
  }
}

// Halaman Detail Tugas
class TaskDetailScreen extends StatelessWidget {
  final int taskIndex;
  final String taskTitle;
  final String taskNote;
  final Function(String) onUpdate;

  const TaskDetailScreen({
    super.key,
    required this.taskIndex,
    required this.taskTitle,
    required this.taskNote,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(taskTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Catatan Tugas:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              taskNote.isEmpty ? "Belum ada catatan." : taskNote,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () async {
                final updatedNote = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      taskTitle: taskTitle,
                      initialNote: taskNote,
                    ),
                  ),
                );
                if (updatedNote != null) {
                  onUpdate(updatedNote);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "EDIT CATATAN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
