import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RekapDataController {
  final DataPasien dataPasien;
  bool isDataDeleted = false;

  // Tambahkan controller
  final TextEditingController rumahSakitController = TextEditingController();
  final TextEditingController namaPasienController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();

  RekapDataController(this.dataPasien) {
    // Inisialisasi controller dengan data awal
    rumahSakitController.text = dataPasien.rumahSakit;
    namaPasienController.text = dataPasien.namaPasien;
    tanggalLahirController.text = dataPasien.tanggalLahir;
    noTeleponController.text = dataPasien.nomorTelepon;
  }

  Future<void> saveDataToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('rumahSakit', rumahSakitController.text);
    prefs.setString('namaPasien', namaPasienController.text);
    prefs.setString('tanggalLahir', tanggalLahirController.text);
    prefs.setString('noTelepon', noTeleponController.text);
  }

  Future<void> loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    rumahSakitController.text = prefs.getString('rumahSakit') ?? '';
    namaPasienController.text = prefs.getString('namaPasien') ?? '';
    tanggalLahirController.text = prefs.getString('tanggalLahir') ?? '';
    noTeleponController.text = prefs.getString('noTelepon') ?? '';
  }

  void updateData(DataPasien updatedData) {
    rumahSakitController.text = updatedData.rumahSakit;
    namaPasienController.text = updatedData.namaPasien;
    tanggalLahirController.text = updatedData.tanggalLahir;
    noTeleponController.text = updatedData.nomorTelepon;
  }

  Future<void> clearDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void dispose() {
    rumahSakitController.dispose();
    namaPasienController.dispose();
    tanggalLahirController.dispose();
    noTeleponController.dispose();
  }
}
