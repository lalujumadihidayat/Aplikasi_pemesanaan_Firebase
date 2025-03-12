import 'package:flutter/material.dart';

class AddPromoPage extends StatelessWidget {
  final Function(String) onAddPromo;

  const AddPromoPage({Key? key, required this.onAddPromo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController imageUrlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Promo Baru'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama Promo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL Gambar Promo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (imageUrlController.text.isNotEmpty) {
                  onAddPromo(imageUrlController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('URL gambar tidak boleh kosong')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Simpan Promo'),
            ),
          ],
        ),
      ),
    );
  }
}