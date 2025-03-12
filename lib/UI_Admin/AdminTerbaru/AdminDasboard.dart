import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/AdminTerbaru/dokter.dart';
import 'package:mob3_uas_klp_09/UI_Admin/AdminTerbaru/promo.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/Admin/settings_admin.dart';
import 'package:mob3_uas_klp_09/UI_Admin/TokoObatAdmin.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/MedialCheckUp.dart';

class AdminTerbaru extends StatelessWidget {
  const AdminTerbaru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
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
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminSettingsScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('person.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatsCard(
                          'Total Pesanan:',
                          '2',
                          'Lihat detail...',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Total Paket:',
                          '6',
                          'Lihat banyak...',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStatsCard(
                    'Total Angsuran:',
                    'RP.200.000',
                    'Lihat tempo angsuran...',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _buildMenuButton(
                      'Promo Menarik',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Promo(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      'Toko Obat',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TokoObatAdmin(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      'Medical Checkup',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedicalCheckup(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      'Dokter',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const dokter(),
                        ),
                      ),
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

  Widget _buildMenuButton(String title, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.teal.withOpacity(0.2),
        highlightColor: Colors.teal.withOpacity(0.1),
        child: Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}