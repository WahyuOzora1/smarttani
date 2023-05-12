import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smarttaniapp/models/plant_model.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/constant/url.dart';

class PenangananProdukScreen extends StatefulWidget {
  final Plant plant;
  final String selected;
  const PenangananProdukScreen(
      {super.key, required this.plant, required this.selected});

  @override
  State<PenangananProdukScreen> createState() => _PenangananProdukScreenState();
}

class _PenangananProdukScreenState extends State<PenangananProdukScreen> {
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
            Text(
              widget.plant.nama,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: () {}, child: _buildChildNama()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildChilPenanganan(),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 20, bottom: 5),
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Text(
            //         "SMARTANI",
            //         style: TextStyle(fontSize: 24),
            //       )),
            // )
          ],
        ),
      )),
    );
  }

  Widget _buildChildNama() {
    if (widget.selected == "Penyemaian") {
      return const Text("Penyemaian");
    } else if (widget.selected == "Penanaman") {
      return const Text("Penanaman");
    } else if (widget.selected == "Perawatan") {
      return const Text("Perawatan");
    } else if (widget.selected == "Pemanenan") {
      return const Text("Pemanenan");
    } else if (widget.selected == "Penanganan Hama Penyakit") {
      return const Text("Penanganan Hama Penyakit");
    } else {
      return const Text("Rekomendasi Pupuk");
    }
  }

  Widget _buildChilPenanganan() {
    if (widget.selected == "Penyemaian") {
      return Text(widget.plant.penyemaian ?? "", textAlign: TextAlign.justify);
    } else if (widget.selected == "Penanaman") {
      return Text(widget.plant.penanaman ?? "", textAlign: TextAlign.justify);
    } else if (widget.selected == "Perawatan") {
      return Text(widget.plant.perawatan ?? "", textAlign: TextAlign.justify);
    } else if (widget.selected == "Pemanenan") {
      return Text(widget.plant.pemanenan ?? "", textAlign: TextAlign.justify);
    } else if (widget.selected == "Penanganan Hama Penyakit") {
      return Text(widget.plant.penangananHama ?? "",
          textAlign: TextAlign.justify);
    } else {
      return Text(widget.plant.rekomendasiPupuk ?? "",
          textAlign: TextAlign.justify);
    }
  }
}
