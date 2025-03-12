class DataPasien {
  final String id;
  late final String rumahSakit;
  late final String namaPasien;
  late final String tanggalLahir;
  late final String nomorTelepon;
  final String harga;
  final String? tanggalpemeriksaan;
  late final String? selectedPackge;
  late final String? selectedPrice;

  DataPasien({
    required this.id,
    required this.rumahSakit,
    required this.namaPasien,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.harga,
    this.tanggalpemeriksaan,
    this.selectedPackge,
    this.selectedPrice,
  });


  // Konversi dari Map (Firestore ke objek DataPasien)
  factory DataPasien.fromMap(Map<String, dynamic> map) {
    return DataPasien(
      id: map['id'] ?? '',
      rumahSakit: map['rumahSakit'] ?? '',
      namaPasien: map['namaPasien'] ?? '',
      tanggalLahir: map['tanggalLahir'] ?? '',
      nomorTelepon: map['nomorTelepon'] ?? '',
      harga: map['harga'] ?? '',
      tanggalpemeriksaan: map['tanggalpemeriksaan'] ?? '',
      selectedPackge: map['selectedPackge'] ?? '',
      selectedPrice: map['selectedPrice'] ?? '',
    );
  }

  // Konversi dari objek DataPasien ke Map (untuk disimpan di Firestore)
  Map<String, dynamic> toMap() {
    return {
      'rumahSakit': rumahSakit,
      'namaPasien': namaPasien,
      'tanggalLahir': tanggalLahir,
      'nomorTelepon': nomorTelepon,
      'tanggalpemeriksaan': tanggalpemeriksaan,
      'harga': harga,
      'selectedPackge': selectedPackge,
      'selectedPrice': selectedPrice,
    };
  }
}
