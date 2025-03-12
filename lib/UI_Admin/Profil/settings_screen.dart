import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/profile_screen.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildProfileItem(context),
                Divider(),
                // _buildSettingsItem(
                //   context,
                //   icon: Icons.health_and_safety_outlined,
                //   title: 'Akses Kesehatan Saya',
                //   onTap: () {},
                // ),
                _buildSettingsItem(
                  context,
                  icon: Icons.password_outlined,
                  title: 'Ubah Password',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.feedback_outlined,
                  title: 'Pembayaran',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Bantuan',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Syarat & Ketentuan',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: OutlinedButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(
                  color: AppTheme.primary,
                  width: 1,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Keluar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Removed context parameter
  Widget _buildProfileItem(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/Jake Enha.jpg'),
      ),
      title: Text(
        'Nama Pengguna',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        'View Profile',
        style: TextStyle(fontSize: 14),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      },
    );
  }

  Widget _buildSettingsItem(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                'Anda yakin ingin keluar dari aplikasi?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Anda perlu masuk ke akun (nama aplikasi) untuk menggunakan layanan aplikasi (nama aplikasi).",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Ya",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.orange),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Batalkan",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
