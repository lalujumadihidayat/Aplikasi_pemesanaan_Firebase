import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_anggota/DasboardAnggota.dart';
import 'package:mob3_uas_klp_09/UI_anggota/checkupAngota.dart';
import 'package:mob3_uas_klp_09/UI_anggota/tokoObatAnggota.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/Dasboard.dart';
import 'package:mob3_uas_klp_09/UI_awal_SebeleumLogin/MedialCheckUp.dart';
import 'package:mob3_uas_klp_09/controller/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Kelompok9());
}

class Kelompok9 extends StatelessWidget {
  const Kelompok9({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dasboard(),
      // home: DasboardAnggota()
      // home: DashboarAdmin(),
      // home: AdminTerbaru(),
      // home: TokoObatAnggota(),
      // home: MedicalCheckupAnggota(),
    );
  }
}