import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smarttaniapp/models/api/plant_api.dart';
import 'package:smarttaniapp/screens/admin/all_plant_admin_screen.dart';
import 'package:smarttaniapp/screens/home_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  PlantServices plantService = PlantServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Dashboard Admin"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4wnb89pdcOxybIAhmpmPjBuzbl5Id4lhhpisiBNqfmpf9h2pFRwTsLPvEUxcODFg3Pn4"),
            ),
            ListTile(
              title: const Text('Daftar Tanaman'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AllPlantAdminScreen()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: 230,
              child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_M9p23l.json"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: const [
                    Text(
                      "SELAMAT DATANG",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "ADMIN",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
