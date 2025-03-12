import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/sukses.dart';



class Bayar extends StatefulWidget {
  final DataPasien dataPasien;
  const Bayar({Key? key, required this.dataPasien}) : super(key: key);

  @override
  State<Bayar> createState() => _BayarState();
}

class _BayarState extends State<Bayar> {
  String? selectedPayment;
  bool saveData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
                        'Bayar',
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
                      _buildStepLine(true),
                      _buildStep(4, 'Bayar', true),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Payment Summary
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Summary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Harga Produk'),
                                Text('10.000.000'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Diskon Promo'),
                                Text('0'),
                              ],
                            ),
                            Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Tagihan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.dataPasien.harga,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Payment Methods
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment methods',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildPaymentOption(
                              'BNI',
                              'images/BNI.png',
                              'Transfer Via BNI\n8923928492',
                            ),
                            _buildPaymentOption(
                              'mandiri',
                              'images/MANDIRI.png',
                              'Transfer Via Mandiri\n89239284922',
                            ),
                            _buildPaymentOption(
                              'bri',
                              'images/BRI.png',
                              'Transfer Via BRI\n89239284922',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Save Data Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: saveData,
                            onChanged: (value) {
                              setState(() {
                                saveData = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFF1A237E),
                          ),
                          const Text('Save Data'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Total Price and Pay Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Price',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                widget.dataPasien.harga,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: selectedPayment != null ? () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BayarSukses(dataPasien: widget.dataPasien,)));
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A237E),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Pay now'),
                          ),
                        ],
                      ),
                    ],
                  ),
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

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, String image, String title) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedPayment,
      onChanged: (newValue) {
        setState(() {
          selectedPayment = newValue;
        });
      },
      title: Row(
        children: [
          Image.asset(
            image,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      activeColor: const Color(0xFF1A237E),
    );
  }
}