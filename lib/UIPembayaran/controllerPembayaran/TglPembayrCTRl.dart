import 'package:cloud_firestore/cloud_firestore.dart';

class TanggalPembayaranController {
  final CollectionReference _tanggalCollection =
      FirebaseFirestore.instance.collection('pembayaran');

  Future<void> simpanTanggalDanWaktu(int day, String time) async {
    try {
      await _tanggalCollection.add({
        'tanggal': day,
        'waktu': time,
        'createdAt': Timestamp.now(),
      });
      print('Data berhasil disimpan ke Firestore');
    } catch (e) {
      print('Error saat menyimpan data: $e');
    }
  }
}
