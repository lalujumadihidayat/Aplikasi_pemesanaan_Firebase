import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/InformasiCTRL.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';


class UpdateInformasiPasien extends StatefulWidget {
  final DataPasien dataPasien;

  const UpdateInformasiPasien({super.key, required this.dataPasien});

  @override
  State<UpdateInformasiPasien> createState() => _UpdateInformasiPasienState();
}

class _UpdateInformasiPasienState extends State<UpdateInformasiPasien> {
  final FirebaseController firebaseController = FirebaseController();
  final TextEditingController _namaPasienController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _hospitals = [
    'RS Harapan Bunda',
    'RS Mitra Keluarga',
    'RS Siloam',
    'RS Hermina',
    'RS Mataram ',
  ];
  String? _selectedHospital;

  @override
  void initState() {
    super.initState();
    _namaPasienController.text = widget.dataPasien.namaPasien;
    _nomorTeleponController.text = widget.dataPasien.nomorTelepon;
    _selectedHospital = widget.dataPasien.rumahSakit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Update Informasi Pasien',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFormLabel('Rumah Sakit*'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedHospital,
                            hint: const Text('Pilih Rumah Sakit'),
                            isExpanded: true,
                            items: _hospitals.map((hospital) {
                              return DropdownMenuItem(
                                value: hospital,
                                child: Text(hospital),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHospital = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFormLabel('Nama pasien sesuai KTP*'),
                      TextFormField(
                        controller: _namaPasienController,
                        decoration: _inputDecoration('Ketikan Nama'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama pasien harus diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildFormLabel('Nomor Telepon*'),
                      TextFormField(
                        controller: _nomorTeleponController,
                        decoration: _inputDecoration('').copyWith(
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('+62'),
                                const SizedBox(width: 4),
                                Container(
                                  width: 1,
                                  height: 24,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor telepon harus diisi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final updatedData = DataPasien(
                        id: widget.dataPasien.id, // Pastikan ID dokumen diteruskan
                        rumahSakit: _selectedHospital ?? '',
                        namaPasien: _namaPasienController.text,
                        nomorTelepon: _nomorTeleponController.text,
                        tanggalLahir: widget.dataPasien.tanggalLahir,
                        harga: widget.dataPasien.harga
                      );

                      // Panggil metode updatePasien
                      // await firebaseController.updatePasien(
                      //     widget.dataPasien.id, updatedData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data pasien berhasil diperbarui'),
                        ),
                      );

                      // Kembali ke halaman sebelumnya
                      Navigator.pop(context, updatedData);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Gagal memperbarui data pasien'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'UPDATE DATA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1A237E)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
