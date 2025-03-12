import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/settings_admin.dart';
import 'package:mob3_uas_klp_09/UI_Admin/TokoObatAdmin.dart';
import 'package:mob3_uas_klp_09/UI_Admin/checkUpAdmin.dart';

class DashboarAdmin extends StatelessWidget {
  const DashboarAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari',
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A237E),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.tune, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Stats Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.0,
                        children: [
                          _buildStatsCard('Total Pesanan:', '2', 'Lihat detail...'),
                          _buildStatsCard('Total Anggota:', '6', 'Lihat detail...'),
                          _buildStatsCard('Total Paket:', '6', 'Lihat detail...'),
                          _buildStatsCard('Total Angsuran:', 'RP.200.000', 'Lihat detail angsuran...'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Services Section
                      const Text(
                        'Layanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Services Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TokoObatAdmin()));
                              print('Toko Obat ditekan');
                            },
                            child: _buildServiceItem(
                              Icons.medication,
                              'Toko Obat',
                              Colors.purple.shade200,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MedicalCheckupAdmin()));
                              print('Medical Checkup ditekan');
                            },
                            child: _buildServiceItem(
                              Icons.medical_information,
                              'Medical Checkup',
                              Colors.pink.shade200,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/dokterPage');
                              print('Dokter ditekan');
                            },
                            child: _buildServiceItem(
                              Icons.person_3,
                              'Dokter',
                              Colors.orange.shade200,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/lainnyaPage');
                              print('Lainnya ditekan');
                            },
                            child: _buildServiceItem(
                              Icons.more_horiz,
                              'Lainnya',
                              Colors.blue.shade200,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Promos Section
                      const Text(
                        'Promo Menarik',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // SizedBox(width: 100,),
                      Column(
                        children: [
                          _buildPromoCard('images/promo1.png'),
                          const SizedBox(height: 16),
                          _buildPromoCard('images/promo2.png'),
                          const SizedBox(height: 16),
                          _buildPromoCard('images/promo3.png'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      Icons.home,
                      'Beranda',
                      true,
                      onTap: () {
                        print('Beranda ditekan');
                      },
                    ),
                    _buildNavItem(
                      Icons.access_time,
                      'Aktivitas Saya',
                      false,
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSettingsScreen(),));
                        print('Aktivitas Saya ditekan');
                      },
                    ),
                    _buildNavItem(
                      Icons.notifications,
                      'Notifikasi',
                      false,
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSettingsScreen(),));
                        print('Notifikasi ditekan');
                      },
                    ),
                    _buildNavItem(
                      Icons.person,
                      'Profil',
                      false,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSettingsScreen(),));
                        print('Profil ditekan');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1DE9B6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(String imageUrl) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF1A237E) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
