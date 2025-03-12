import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/editprofile_screen.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(color: AppTheme.primary, fontSize: 16),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/Jake Enha.jpg')),
                  SizedBox(height: 10),
                  Text(
                    "Nama Pengguna",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "email@example.com",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildProfileItem("Nomor Telepon", "087864123000"),
                  Divider(),
                  _buildProfileItem("Tanggal Lahir", "16/10/2004"),
                  Divider(),
                  _buildProfileItem("Jenis Kelamin", "Perempuan"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildPasswordItem(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileItem(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildPasswordItem(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Change Password",
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
