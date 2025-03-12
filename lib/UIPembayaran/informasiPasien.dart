import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/InformasiCTRL.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/konfirmasiPasien.dart';


class Informasipasien extends StatefulWidget {
  const Informasipasien({super.key});

  @override
  State<Informasipasien> createState() => _InformasipasienState();
}

class _InformasipasienState extends State<Informasipasien> {
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

  // Variables for date selection
  int? _selectedDay;
  String? _selectedMonth;
  int? _selectedYear;

  final List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

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
              child: Column(
                children: [
                  // Back button and title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Informasi Pasien',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress steps
                  Row(
                    children: [
                      _buildStep(1, 'Pilih Tanggal', true),
                      _buildStepLine(true),
                      _buildStep(2, 'Informasi Pasien', true),
                      _buildStepLine(false),
                      _buildStep(3, 'Konfirmasi', false),
                      _buildStepLine(false),
                      _buildStep(4, 'Bayar', false),
                    ],
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
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Pilih rumah sakit terdekat dengan Lokasi saya',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
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
                      _buildFormLabel('Tanggal Lahir*'),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedDay,
                              hint: const Text('Tanggal'),
                              items: List.generate(31, (index) => index + 1)
                                  .map((day) => DropdownMenuItem(
                                        value: day,
                                        child: Text(day.toString()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedDay = value;
                                });
                              },
                              decoration: _inputDecoration(''),
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih tanggal';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedMonth,
                              hint: const Text('Bulan'),
                              items: _months
                                  .map((month) => DropdownMenuItem(
                                        value: month,
                                        child: Text(month),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMonth = value;
                                });
                              },
                              decoration: _inputDecoration(''),
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih bulan';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedYear,
                              hint: const Text('Tahun'),
                              items: List.generate(100,
                                      (index) => DateTime.now().year - index)
                                  .map((year) => DropdownMenuItem(
                                        value: year,
                                        child: Text(year.toString()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedYear = value;
                                });
                              },
                              decoration: _inputDecoration(''),
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih tahun';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
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
                      final dataPasien = DataPasien(
                        id: 'some_unique_id', // Add the required 'id' parameter
                        rumahSakit: _selectedHospital ?? '',
                        namaPasien: _namaPasienController.text,
                        tanggalLahir:
                            '${_selectedDay ?? ''} ${_selectedMonth ?? ''} ${_selectedYear ?? ''}',
                        nomorTelepon: _nomorTeleponController.text,
                        harga: '10.000.000', // Add the required 'harga' parameter
                      );

                      await firebaseController.addPasien(dataPasien);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Data pasien berhasil disimpan')),
                      );

                      // Pindah ke halaman konfirmasi
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Konfirmasipasien(dataPasien: dataPasien),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Gagal menyimpan data pasien')),
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
                  'SUBMIT DATA',
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

  Widget _buildStep(int number, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      height: 1,
      width: 20,
      color: isActive ? const Color(0xFF1A237E) : Colors.grey,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
