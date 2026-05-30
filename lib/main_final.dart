import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DocuScanPro());
}

class DocuScanPro extends StatelessWidget {
  const DocuScanPro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuScan Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AuthGate(),
    );
  }
}