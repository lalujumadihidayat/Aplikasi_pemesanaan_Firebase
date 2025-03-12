import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/AdminTerbaru/FiturTambah/addPromo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Promo extends StatefulWidget {
  const Promo({Key? key}) : super(key: key);

  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  List<String> promoImages = [];

  @override
  void initState() {
    super.initState();
    _loadPromos();
  }

  Future<void> _loadPromos() async {
    final prefs = await SharedPreferences.getInstance();
    final promos = prefs.getStringList('promoImages') ?? [];
    setState(() {
      promoImages = promos;
    });
  }

  Future<void> _addPromo(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      promoImages.add(imageUrl);
    });
    await prefs.setStringList('promoImages', promoImages);
  }

  Future<void> _removePromo(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      promoImages.remove(imageUrl);
    });
    await prefs.setStringList('promoImages', promoImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back arrow button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Promo Menarik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: promoImages.map((imageUrl) {
                      return Column(
                        children: [
                          _buildPromoCard(
                            context,
                            imageUrl,
                            () {
                              print('$imageUrl ditekan');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$imageUrl sudah ditambahkan')),
                              );
                            },
                            () => _removePromo(imageUrl),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // Add button at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPromoPage(onAddPromo: _addPromo),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambah Promo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCard(BuildContext context, String imageUrl, Function() onTap, Function() onDelete) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Hapus Promo',
            ),
          ),
        ],
      ),
    );
  }
}