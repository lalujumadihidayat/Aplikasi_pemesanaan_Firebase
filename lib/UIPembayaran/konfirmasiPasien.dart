import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/bayar.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';


class Konfirmasipasien extends StatefulWidget {
  final DataPasien dataPasien;

  const Konfirmasipasien({Key? key, required this.dataPasien})
      : super(key: key);

  @override
  State<Konfirmasipasien> createState() => _KonfirmasipasienState();
}

class _KonfirmasipasienState extends State<Konfirmasipasien> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with steps
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
                        'Konfirmasi Data Pasien',
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
                      _buildStepLine(true),
                      _buildStep(3, 'Konfirmasi', true),
                      _buildStepLine(false),
                      _buildStep(4, 'Bayar', false),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Patient Details Card
                    _buildSectionCard(
                      'Detail Pasien',
                      [
                        // DetailPasien(dataPasien: widget.dataPasien),
                        _buildDetailRow('Rumah Sakit Pilihan',
                            widget.dataPasien.rumahSakit),
                        _buildDetailRow(
                            'Nama Pasien', widget.dataPasien.namaPasien),
                        _buildDetailRow(
                            'Tanggal Lahir', widget.dataPasien.tanggalLahir),
                        _buildDetailRow(
                            'Nomor Telepon', widget.dataPasien.nomorTelepon),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Package Details Card
                    _buildSectionCard(
                      'Detail Paket',
                      [
                        _buildDetailRow('Brain Check Up Plus + Package',
                            'Siloam Platinum (Female)'),
                        _buildDetailRow(
                            'Tanggal Pemeriksaan', '30 January 2025 - 10:30'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Terms Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: isTermsAccepted,
                          onChanged: (value) {
                            setState(() {
                              isTermsAccepted = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF1A237E),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Ya, saya setuju dengan ',
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'syarat & ketentuan',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' yang ada.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Price and Payment Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.dataPasien.harga,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: isTermsAccepted
                              ? () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Bayar(dataPasien: widget.dataPasien,)));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'BAYAR SEKARANG',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
            ),
          ),
        ],
      ),
    );
  }
}
