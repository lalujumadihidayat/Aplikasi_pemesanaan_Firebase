import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';


class ManageAdminAccountScreen extends StatefulWidget {
  const ManageAdminAccountScreen({super.key});

  @override
  _ManageAdminAccountScreenState createState() =>
      _ManageAdminAccountScreenState();
}

class _ManageAdminAccountScreenState extends State<ManageAdminAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Simulasi data awal akun admin
  String _profileImage = 'assets/profile_placeholder.png';

  @override
  void initState() {
    super.initState();
    // Set default data jika ada
    _nameController.text = 'Admin';
    _emailController.text = 'admin@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Akun Admin'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: AppTheme.primary,
                      backgroundImage: AssetImage(_profileImage),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: _changeProfileImage,
                        icon: Icon(
                          Icons.camera_alt,
                          color: AppTheme.primary,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("Nama Lengkap", _nameController),
              SizedBox(height: 10),
              _buildTextField("Email", _emailController),
              SizedBox(height: 10),
              _buildTextField("Password", _passwordController, obscureText: true),
              SizedBox(height: 10),
              _buildTextField("Konfirmasi Password", _confirmPasswordController, obscureText: true),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _saveAccountSettings,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(
                        color: AppTheme.primary,
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: AppTheme.primary),
            ),
            hintText: label,
          ),
        ),
      ],
    );
  }

  // Function to handle profile image change (simulation)
  void _changeProfileImage() {
    // Add image picker logic here (use image_picker package)
    setState(() {
      _profileImage = 'assets/new_profile_image.png';  // Simulate new image selection
    });
  }

  // Save changes function
  void _saveAccountSettings() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      // Show an error if passwords don't match
      _showErrorDialog('Password tidak cocok');
      return;
    }

    // Save logic (for example, update in database, etc.)
    // You can add your backend logic here

    // Show success message
    _showSuccessDialog('Akun berhasil diperbarui');
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Function to show a success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
