import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/user_model.dart';

class SignupDataSource {
  static String errorMessage = '';
  static bool isLoading = false;

  static Future<bool> signup({
    required String email,
    required String password,
    required String name,
    required int phone,
  }) async {
    try {
      isLoading = true;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        isLoading = false;
        setUserData(
          name: name,
          phone: phone,
          email: email,
          password: password,
          uid: credential.user!.uid,
        );
        return true;
      } else {
        throw Exception('User not found');
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      errorMessage = e.message ?? 'An error occurred';
      print(e);
      return false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      print(e);
      return false;
    }
  }

  static Future<void> setUserData({
    required String name,
    required int phone,
    required String email,
    required String password,
    required String uid,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      email: email,
      password: password,
      uid: uid,
    );
    users.doc(uid).set(userModel.toMap());
  }

  static Future<UserModel> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    return UserModel.fromMap(doc.data() ??
        {
          'name': 'null',
          'phone': 'null',
          'email': 'null',
        });
  }
}
