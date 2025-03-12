import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _phoneCont = TextEditingController();
  final TextEditingController _birthDateCont = TextEditingController();
  String gender = '';

  @override
  void initState() {
    super.initState();
    // Remove backend data initialization.
    _nameCont.text = 'Admin';
    _emailCont.text = 'email@gmail.com';
    _phoneCont.text = '087864123000';
    _birthDateCont.text = '16/10/2004';
    gender = 'Perempuan';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: AppTheme.primary,
                        backgroundImage: AssetImage('assets/Jake Enha.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
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
                _buildTextField("Nama Lengkap", _nameCont),
                SizedBox(height: 10),
                _buildTextField("Email", _emailCont),
                SizedBox(height: 10),
                _buildTextField("Nomor Telepon", _phoneCont),
                SizedBox(height: 10),
                _buildDateField("Tanggal Lahir"),
                SizedBox(height: 10),
                _buildGenderField(),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Placeholder for save action, but no backend code
                      },
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
                      child: const Text(
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
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
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

  Widget _buildDateField(String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          _birthDateCont.text =
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(label, _birthDateCont),
      ),
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Jenis Kelamin", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<String>(
              value: "Pria",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            Text("Pria"),
            SizedBox(width: 50),
            Radio<String>(
              value: "Perempuan",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            Text("Perempuan"),
          ],
        ),
      ],
    );
  }
}
