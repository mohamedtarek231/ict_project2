import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/upload_products_firebase.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/ui/buttom_navigation_bar.dart';
import 'package:flutter_application_1/ui/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UploadProductsFirebase.uploadProducts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const CustomBottomNavigationBar()
          : const LoginScreen(),
    );
  }
}
