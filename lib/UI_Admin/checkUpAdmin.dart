import 'package:flutter/material.dart';

class MedicalCheckupAdmin extends StatefulWidget {
  const MedicalCheckupAdmin({super.key});

  @override
  State<MedicalCheckupAdmin> createState() => _MedicalCheckupAdminState();
}

class _MedicalCheckupAdminState extends State<MedicalCheckupAdmin> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allPackages = [
    {'title': 'Brain Check Up Plus + Package', 'price': 'Rp 10.900.000', 'isAvailable': false},
    {'title': 'Cervix Cancer Package', 'price': 'Rp 750.000', 'isAvailable': true},
    {'title': 'Basic Stroke Screening', 'price': 'Rp 400.000', 'isAvailable': true},
    {'title': 'Advanced Stroke Screening', 'price': 'Rp 2.250.000', 'isAvailable': false},
    {'title': 'Heart Check Up Package', 'price': 'Rp 5.000.000', 'isAvailable': true},
    {'title': 'Full Body Screening', 'price': 'Rp 8.750.000', 'isAvailable': true},
  ];

  List<Map<String, dynamic>> filteredPackages = [];

  @override
  void initState() {
    super.initState();
    filteredPackages = allPackages;
    _searchController.addListener(_filterPackages);
  }

  void _filterPackages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPackages = allPackages
          .where((pkg) => pkg['title'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Medical Checkup',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari',
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A237E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Apa Paket Terbaik untuk saya?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kami bantu menemukan paket yang sesuai kebutuhan Kamu',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pelajari Lebih lanjut →',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Package Section Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Pilihan Paket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Packages Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: filteredPackages.length,
                  itemBuilder: (context, index) {
                    final pkg = filteredPackages[index];
                    return _buildPackageCard(pkg['title'], pkg['price'], pkg['isAvailable']);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(String title, String price, bool isAvailable) {
    return InkWell(
      onTap: () {
        // Aksi ketika card ditekan
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isAvailable ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isAvailable ? Colors.green.withOpacity(0.5) : Colors.orange.withOpacity(0.5),
                ),
              ),
              child: Text(
                isAvailable ? 'Jadwal Tersedia' : 'Jadwal Belum Tersedia',
                style: TextStyle(
                  fontSize: 12,
                  color: isAvailable ? Colors.green : Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
