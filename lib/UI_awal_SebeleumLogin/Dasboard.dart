import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/MedialCheckUp.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/TokoObat.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/aktivitasSaya.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/notifikasi.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/profil.dart';
import 'package:mob3_uas_klp_09/ui/login.dart';

class Dasboard extends StatelessWidget {
  const Dasboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
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
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A237E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Search Bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.search, color: Colors.grey),
                                  hintText: 'Cari',
                                  border: InputBorder.none,
                                ),
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
                      const SizedBox(height: 24),

                      // Layanan Section
                      const Text(
                        'Layanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const TokoObatScreen()),
                              );
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MedicalCheckup()));
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
                      Column(
                        children: [
                          _buildPromoCard(
                            'images/promo1.png',
                            () {
                              print('Promo 1 ditekan');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Anda Harus Login Dulu')),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildPromoCard(
                            'images/promo2.png',
                            () {
                              print('Promo 2 ditekan');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Anda Harus Login dulu!!')),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildPromoCard(
                            'images/promo3.png',
                            () {
                              print('Promo 3 ditekan');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Anda Harus Login Dulu!!!!')),
                              );
                            },
                          ),
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
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        print('Navigasi ke Beranda');
                      },
                      child: _buildNavItem(Icons.home, 'Beranda', true),
                    ),
                    InkWell(
                      onTap: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Aktivitassaya())
                        );
                        print('Navigasi ke Aktivitas Saya');
                      },
                      child: _buildNavItem(Icons.access_time, 'Aktivitas Saya', false),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Notifikasi())
                        );
                        print('Navigasi ke Notifikasi');
                      },
                      child: _buildNavItem(Icons.notifications, 'Notifikasi', false),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Profil()));
                        print('Navigasi ke Profil');
                      },
                      child: _buildNavItem(Icons.person, 'Profil', false),
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

  Widget _buildPromoCard(String imageUrl, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 230,
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
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
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
    );
  }
}
