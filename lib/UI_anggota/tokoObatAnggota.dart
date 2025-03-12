import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_anggota/detailObat/detailObat.dart';

class TokoObatAnggota extends StatefulWidget {
  const TokoObatAnggota({Key? key}) : super(key: key);

  @override
  State<TokoObatAnggota> createState() => _TokoObatAnggotaState();
}

class _TokoObatAnggotaState extends State<TokoObatAnggota> {
  final List<Map<String, String>> medicines = [
    {'name': 'Paracetamol', 'price': 'Rp 500.000'},
    {'name': 'Amoxicillin', 'price': 'Rp 1.000.000'},
    {'name': 'Ibuprofen', 'price': 'Rp 150.000'},
    {'name': 'Cetirizine', 'price': 'Rp 2.000.000'},
    {'name': 'Omeprazole', 'price': 'Rp 2.500.000'},
    {'name': 'Captopril', 'price': 'Rp 300.000'},
    {'name': 'Aspirin', 'price': 'Rp 350.000'},
    {'name': 'Metformin', 'price': 'Rp 4.000.000'},
    {'name': 'Salbutamol', 'price': 'Rp 4.500.000'},
    {'name': 'Diclofenac', 'price': 'Rp 500.000'},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = medicines
        .where((medicine) => medicine['name']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Toko Obat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search, color: Colors.grey),
                          hintText: 'Cari',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A237E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Medicine List Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilihan Obat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Medicine Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: filteredMedicines.length,
                  itemBuilder: (context, index) {
                    final String medicineName = filteredMedicines[index]['name']!;
                    final String price = filteredMedicines[index]['price']!;
                    return _MedicineCard(
                      name: medicineName,
                      price: price,
                      onTap: () {
                        _showConfirmationDialog(context, medicineName);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String medicineName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pilihan'),
          content: Text('Apakah Anda ingin memilih $medicineName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailobat(medicineName: medicineName),
                  ),
                );
              },
              child: Text('Oke'),
            ),
          ],
        );
      },
    );
  }
}

class _MedicineCard extends StatelessWidget {
  final String name;
  final String price;
  final VoidCallback onTap;

  const _MedicineCard({
    Key? key,
    required this.name,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
