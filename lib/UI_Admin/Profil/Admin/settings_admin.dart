import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/manageaccount.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/payment_manage.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/report_stats.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/user_management.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';
import 'package:mob3_uas_klp_09/ui/login.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Admin'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Profil Admin
                _buildProfileItem(context),
                Divider(),

                // Manajemen Pengguna
                _buildSettingsItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Manajemen Pengguna',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserManagementScreen()),
                    );
                  },
                ),

                // Manajemen Pembayaran
                _buildSettingsItem(
                  context,
                  icon: Icons.payment_outlined,
                  title: 'Manajemen Pembayaran',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentManagementScreen()),
                    );
                  },
                ),

                // Laporan & Statistik
                _buildSettingsItem(
                  context,
                  icon: Icons.bar_chart_outlined,
                  title: 'Laporan & Statistik',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportAndStatsScreen()),
                    );
                  },
                ),

                // Pengaturan Aplikasi
                _buildSettingsItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan Aplikasi',
                  onTap: () {
                    // Navigasi ke halaman pengaturan aplikasi
                  },
                ),

                // Bantuan
                _buildSettingsItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Bantuan',
                  onTap: () {
                    // Navigasi ke halaman bantuan
                  },
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

  // Profile Admin
  Widget _buildProfileItem(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/admin_profile.jpg'),
      ),
      title: Text(
        'Admin Name',
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
          MaterialPageRoute(builder: (context) => ManageAdminAccountScreen()),
        );
      },
    );
  }

  // Settings Item
  Widget _buildSettingsItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
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
                "Anda perlu masuk ke akun admin untuk menggunakan layanan aplikasi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
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
