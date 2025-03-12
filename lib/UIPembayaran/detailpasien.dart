import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';


class DetailPasien extends StatelessWidget {
  final DataPasien dataPasien;

  const DetailPasien({Key? key, required this.dataPasien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Rumah Sakit Pilihan', dataPasien.rumahSakit),
        _buildDetailRow('Nama Pasien', dataPasien.namaPasien),
        _buildDetailRow('Tanggal Lahir', dataPasien.tanggalLahir),
        _buildDetailRow('Nomor Telepon', dataPasien.nomorTelepon),
      ],
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
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
