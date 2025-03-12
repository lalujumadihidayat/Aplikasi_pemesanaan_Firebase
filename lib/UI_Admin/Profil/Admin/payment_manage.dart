import 'package:flutter/material.dart';

class PaymentManagementScreen extends StatelessWidget {
  const PaymentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Pembayaran'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Riwayat Pembayaran
            Text(
              'Riwayat Pembayaran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: _buildPaymentList(context)),
          ],
        ),
      ),
    );
  }

  // Daftar Pembayaran (Tabel)
  Widget _buildPaymentList(BuildContext context) {
    return ListView.builder(
      itemCount: 10,  // Ganti dengan jumlah pembayaran yang ada
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/payment_placeholder.jpg'), // Ganti dengan gambar terkait pembayaran
            ),
            title: Text('Pembayaran ${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text('Nominal: \$${(index + 1) * 50}', style: TextStyle(fontSize: 14)),
            trailing: Text(
              index % 2 == 0 ? 'Dikonfirmasi' : 'Menunggu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: index % 2 == 0 ? Colors.green : Colors.orange,
              ),
            ),
            onTap: () {
              _showPaymentDetailDialog(context, index);
            },
          ),
        );
      },
    );
  }

  // Dialog untuk melihat detail pembayaran
  void _showPaymentDetailDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Pembayaran ${index + 1}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nominal: \$${(index + 1) * 50}'),
              Text('Metode Pembayaran: Kartu Kredit'),
              Text('Tanggal Pembayaran: 2024-12-${index + 1}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _changePaymentStatus(context, 'Dikonfirmasi', index);
                },
                child: Text('Verifikasi Pembayaran'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                  'Tutup',
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

  // Mengubah status pembayaran
  void _changePaymentStatus(BuildContext context, String status, int index) {
    // Simulasi perubahan status pembayaran
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pembayaran ${index + 1} statusnya diubah menjadi $status')),
    );
    Navigator.pop(context);
  }
}
