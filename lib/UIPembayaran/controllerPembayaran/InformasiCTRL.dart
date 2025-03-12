import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/data_pasien.dart';


  class FirebaseController {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addPasien(DataPasien pasien) async {
      try {
        await _firestore.collection('data_pasien').add({
          ...pasien.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        print('Error menambahkan data pasien: $e');
        rethrow;
      }
    }

//     Future<void> updatePasien(String documentId, DataPasien updatedData) async {
//   try {
//     await _firestore
//         .collection('data_pasien')
//         .doc(documentId)
//         .update(updatedData.toMap());
//   } catch (e) {
//     print('Error memperbarui data pasien: $e');
//     rethrow;
//   }
// }


    Future<List<DataPasien>> getAllPasien() async {
      try {
        QuerySnapshot snapshot =
            await _firestore.collection('data_pasien').get();
        return snapshot.docs.map((doc) {
          return DataPasien.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      } catch (e) {
        print('Error mengambil data pasien: $e');
        rethrow;
      }
    }
  }


