import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/rekap.dart';

class Riwayatpembayaran extends StatelessWidget {
  const Riwayatpembayaran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Saya',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        elevation: 5,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToRekapData(context),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Card ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToRekapData(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RekapData(
          dataPasien: DataPasien(
            id: 'some_id',
            rumahSakit: 'RS Harapan Bunda',
            namaPasien: 'lalu jumadi hidayat',
            tanggalLahir: '11 November 2009',
            nomorTelepon: '1234567',
            harga: '10.000.000',
          ),
        ),
      ),
    );
  }
}
