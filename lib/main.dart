import 'package:flutter/material.dart';
import 'package:manajemen_tugas/ui/list_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Tugas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ListData(), // Menghubungkan ke halaman TugasForm
    );
  }
}