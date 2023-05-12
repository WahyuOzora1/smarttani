import 'package:flutter/material.dart';
import 'package:smarttaniapp/models/plant_model.dart';
import 'package:smarttaniapp/screens/plant/penanganan_produk_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/constant/url.dart';

class DetailProdukScreen extends StatefulWidget {
  final Plant plant;
  const DetailProdukScreen({super.key, required this.plant});

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  final String penyemaian = "Penyemaian";
  final String penanaman = "Penanaman";
  final String perawatan = "Perawatan";
  final String pemanenan = "Pemanenan";
  final String penangananHama = "Penanganan Hama Penyakit";
  final String rekomendasiPupuk = "Rekomendasi Pupuk";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  height: 218,
                  child: Image.network(
                    widget.plant.imageUrl ?? Urls.noImageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 8,
                    left: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.plant.nama,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Kingdom",
                          style:
                              TextStyle(fontSize: 14, color: secondaryColor)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(widget.plant.kingdom,
                          style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Family",
                          style:
                              TextStyle(fontSize: 14, color: secondaryColor)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(widget.plant.family,
                          style: const TextStyle(fontSize: 12))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Solanum lycopersicum",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.plant.deskripsi,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PenangananProdukScreen(
                                              plant: widget.plant,
                                              selected: penyemaian,
                                            )));
                              },
                              child: Text(penyemaian,
                                  style: const TextStyle(fontSize: 12))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              PenangananProdukScreen(
                                                plant: widget.plant,
                                                selected: penanaman,
                                              )));
                                },
                                child: Text(penanaman,
                                    style: const TextStyle(fontSize: 12))),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PenangananProdukScreen(
                                              plant: widget.plant,
                                              selected: perawatan,
                                            )));
                              },
                              child: Text(perawatan,
                                  style: const TextStyle(fontSize: 12))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PenangananProdukScreen(
                                              plant: widget.plant,
                                              selected: pemanenan,
                                            )));
                              },
                              child: Text(pemanenan,
                                  style: const TextStyle(fontSize: 12))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              PenangananProdukScreen(
                                                plant: widget.plant,
                                                selected: penangananHama,
                                              )));
                                },
                                child: const Text(
                                  "Penangan Hama\n Penyakit",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PenangananProdukScreen(
                                              plant: widget.plant,
                                              selected: rekomendasiPupuk,
                                            )));
                              },
                              child: const Text(
                                "Rekomendasi\n Pupuk",
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ],
                  ),
                )),
            const Padding(
              padding: EdgeInsets.only(top: 40, bottom: 5),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "SMARTANI",
                    style: TextStyle(fontSize: 24),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
