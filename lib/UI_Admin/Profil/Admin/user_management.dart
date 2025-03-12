import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Pengguna'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tombol untuk menambah pengguna
            ElevatedButton(
              onPressed: () {
                _showAddUserDialog(context);
              },
              child: Text('Tambah Pengguna Baru'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Daftar Pengguna
            Expanded(child: _buildUserList(context)),
          ],
        ),
      ),
    );
  }

  // Daftar Pengguna (Tabel)
  Widget _buildUserList(BuildContext context) {
    return ListView.builder(
      itemCount: 10,  // Ganti dengan jumlah pengguna yang ada
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/user_placeholder.jpg'), // Ganti dengan gambar profil pengguna
            ),
            title: Text('Pengguna ${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text('Status: ${index % 2 == 0 ? "Aktif" : "Tersuspend"}'),
            trailing: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (String value) {
                // Aksi yang dilakukan ketika pilihan menu dipilih
                if (value == 'Suspend') {
                  _changeUserStatus(context, 'Tersuspend', index);
                } else if (value == 'Aktifkan') {
                  _changeUserStatus(context, 'Aktif', index);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Suspend',
                    child: Text('Suspend Pengguna'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Aktifkan',
                    child: Text('Aktifkan Pengguna'),
                  ),
                ];
              },
            ),
          ),
        );
      },
    );
  }

  // Dialog untuk menambah pengguna
  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pengguna Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Pengguna'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email Pengguna'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk menambahkan pengguna baru
                  String name = nameController.text;
                  String email = emailController.text;
                  if (name.isNotEmpty && email.isNotEmpty) {
                    // Logika untuk menyimpan pengguna baru (misalnya ke database atau API)
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pengguna $name telah ditambahkan')),
                    );
                  }
                },
                child: Text('Tambah Pengguna'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Mengubah status pengguna (Aktif atau Tersuspend)
  void _changeUserStatus(BuildContext context, String status, int index) {
    // Simulasi perubahan status pengguna
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status Pengguna ${index + 1} diubah menjadi $status')),
    );
  }
}
