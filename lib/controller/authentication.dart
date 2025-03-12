import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp User

  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String alamat,
    required String phone,
    required String gender,
    required String username
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          alamat.isNotEmpty ||
          phone.isNotEmpty ||
          gender.isNotEmpty ||
          name.isNotEmpty ||
          username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
          'alamat':alamat,
          'phone':phone,
          'password':password,
          'gender':gender,
          'username':username
        });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
  required String identifier, // Bisa berupa email atau username
  required String password,
}) async {
  String res = "Some error Occurred";
  try {
    if (identifier.isNotEmpty || password.isNotEmpty) {
      String emailToUse = identifier;

      // Periksa apakah identifier adalah username
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(identifier)) {
        // Query Firestore untuk mencari email berdasarkan username
        QuerySnapshot snapshot = await _firestore
            .collection("users")
            .where('username', isEqualTo: identifier)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          emailToUse = snapshot.docs.first['email'];
        } else {
          return "Username not found";
        }
      }

      // Lakukan login dengan email
      await _auth.signInWithEmailAndPassword(
        email: emailToUse,
        password: password,
      );
      res = "success";
    } else {
      res = "Please enter all the fields";
    }
  } catch (err) {
    return err.toString();
  }
  return res;
}


  signOut() async {
  }
}