import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/rekapdataCntoller.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/informasiupdate.dart';
import 'package:mob3_uas_klp_09/UI_anggota/DasboardAnggota.dart';

class RekapData extends StatefulWidget {
  final DataPasien dataPasien;

  const RekapData({
    Key? key,
    required this.dataPasien,
  }) : super(key: key);

  @override
  _RekapDataState createState() => _RekapDataState();
}

class _RekapDataState extends State<RekapData> {
  late RekapDataController controller;

  @override
  void initState() {
    super.initState();
    controller = RekapDataController(widget.dataPasien);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rekap Data Pemeriksaan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.isDataDeleted
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.info_outline, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Data telah dihapus.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 100, 100, 100).withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Rumah Sakit :', controller.rumahSakitController.text),
                              const SizedBox(height: 16),
                              _buildDetailRow('Nama Pasien :', controller.namaPasienController.text),
                              const SizedBox(height: 16),
                              _buildDetailRow('Tanggal Lahir :', controller.tanggalLahirController.text),
                              const SizedBox(height: 16),
                              _buildDetailRow('No. Telepon :', controller.noTeleponController.text),
                              const SizedBox(height: 24),
                              _buildDetailRow('Harga :', widget.dataPasien.harga),
                              const SizedBox(height: 24),
                              _buildDetailRow('Detail Paket :', widget.dataPasien.selectedPackge ?? 'Brain Check Up Plus + Package'),
                              const SizedBox(height: 24),
                              _buildDetailRow('Tanggal Pemeriksaan :', widget.dataPasien.tanggalpemeriksaan ?? '30 January 2025 - 10:30'),
                              const SizedBox(height: 24),
                              // Tombol Hapus dan Update
                              Row(
                                children: [
                                  // Tombol Hapus
                                  ElevatedButton(
                                    onPressed: () => _confirmDelete(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text(
                                      'Hapus Data',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Tombol Update
                                  ElevatedButton(
                                    onPressed: () => _navigateToInformasiPasien(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: const Text(
                                      'Update Data',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                onPressed: () => _navigateToNextPage(context),
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                  size: 30,
                ),
              ),
            ),
          ),
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
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _deleteData(context);
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _deleteData(BuildContext context) {
    setState(() {
      controller.isDataDeleted = true; // Tandai bahwa data sudah dihapus
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus')),
    );
  }

  void _navigateToInformasiPasien(BuildContext context) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateInformasiPasien(dataPasien: widget.dataPasien),
      ),
    );

    // Perbarui tampilan jika ada data baru
    if (updatedData != null && updatedData is DataPasien) {
      setState(() {
        controller.updateData(updatedData);
      });
    }
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DasboardAnggota(username: 'Dayat',),
      ),
    );
  }
}