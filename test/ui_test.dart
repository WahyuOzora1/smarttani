import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smarttaniapp/screens/admin/home_admin_screen.dart';
import 'package:smarttaniapp/screens/admin/tambah_plant_screen.dart';

void main() {
  testWidgets('Halaman pertama admin SELAMAT DATANG',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomeAdminScreen(),
    ));

    expect(find.text('SELAMAT DATANG'), findsOneWidget);
  });

  testWidgets('Judul appbar adalah Tambah tanaman',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TambahPlantScreen(),
    ));

    expect(find.text('Tambah tanaman'), findsOneWidget);
  });
}
