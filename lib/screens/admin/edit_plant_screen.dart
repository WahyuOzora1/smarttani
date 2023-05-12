import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smarttaniapp/models/api/plant_api.dart';
import 'package:smarttaniapp/models/plant_model.dart';
import 'package:smarttaniapp/screens/admin/all_plant_admin_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/widgets/textformfile_widget.dart';

class EditPlantScreen extends StatefulWidget {
  final Plant plant;
  const EditPlantScreen({super.key, required this.plant});

  @override
  State<EditPlantScreen> createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  final namaController = TextEditingController();
  final namaLatinController = TextEditingController();
  final kingdomController = TextEditingController();
  final familyController = TextEditingController();
  final deskripsiController = TextEditingController();
  final penyemaianController = TextEditingController();
  final penanamanController = TextEditingController();
  final perawatanController = TextEditingController();
  final pemanenanController = TextEditingController();
  final penangananHamaController = TextEditingController();
  final rekomendasiPupukController = TextEditingController();
  final fileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validasiName(String? value) {
    if (value!.isEmpty) {
      return "Nama tidak boleh kosong";
    } else {
      return null;
    }
  }

  PlantServices plantService = PlantServices();

  @override
  void dispose() {
    namaController.dispose();
    namaLatinController.dispose();
    kingdomController.dispose();
    familyController.dispose();
    deskripsiController.dispose();
    penyemaianController.dispose();
    penanamanController.dispose();
    perawatanController.dispose();
    pemanenanController.dispose();
    penangananHamaController.dispose();
    rekomendasiPupukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    namaController.text = widget.plant.nama;
    namaLatinController.text = widget.plant.namaLatin;
    kingdomController.text = widget.plant.kingdom;
    familyController.text = widget.plant.family;

    deskripsiController.text = widget.plant.deskripsi;
    penyemaianController.text = widget.plant.penyemaian ?? "";
    penanamanController.text = widget.plant.penanaman ?? "";
    perawatanController.text = widget.plant.perawatan ?? "";
    pemanenanController.text = widget.plant.pemanenan ?? "";

    penangananHamaController.text = widget.plant.penangananHama ?? "";
    rekomendasiPupukController.text = widget.plant.rekomendasiPupuk ?? "";
    fileController.text = widget.plant.imageUrl ?? "";

    String imageUrl = widget.plant.imageUrl ??
        "https://firebasestorage.googleapis.com/v0/b/wahyufirebase.appspot.com/o/images%2F1683627520154?alt=media&token=fdb375f1-ad77-450f-82e6-dcaf52c98c72";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit tanaman"),
        backgroundColor: primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              TextFormField(
                controller: namaController,
                validator: validasiName,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Nama Tanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: namaLatinController,
                validator: validasiName,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Nama Latin Tanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: kingdomController,
                validator: validasiName,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Kingdom Tanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: familyController,
                validator: validasiName,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Family Tanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: deskripsiController,
                validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Deskripsi Tanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: penyemaianController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Cara Penyemaian",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: penanamanController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Cara Penanaman",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: perawatanController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Cara Perawatan",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pemanenanController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Cara Panen",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: penangananHamaController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Penanganan Hama Penyakit",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: rekomendasiPupukController,
                // validator: validasiName,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: primaryColor,
                decoration: textFieldStyle(
                  labelTextStr: "Rekomendasi Pupuk",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // validator: validasiName,
                controller: fileController,
                readOnly: true,
                decoration: InputDecoration(
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  labelText: "Pilih Gambar",
                  icon: IconButton(
                    icon: const Icon(Icons.file_copy),
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      // print("${file?.path}");

                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        await referenceImageToUpload.putFile(File(file!.path));

                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();

                        fileController.text = imageUrl;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Pilih Gambar Berhasil")));

                        // print("ada url imagae? $imageUrl");
                      } catch (e) {
                        throw Exception();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final plant = Plant(
                            nama: namaController.text,
                            namaLatin: namaLatinController.text,
                            kingdom: kingdomController.text,
                            family: familyController.text,
                            deskripsi: deskripsiController.text,
                            penyemaian: penyemaianController.text,
                            penanaman: penanamanController.text,
                            perawatan: perawatanController.text,
                            pemanenan: pemanenanController.text,
                            penangananHama: penangananHamaController.text,
                            rekomendasiPupuk: rekomendasiPupukController.text,
                            imageUrl: imageUrl);
                        plantService.updatePlant(plant, widget.plant.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Edit data Berhasil")));
                        namaController.clear();
                        kingdomController.clear();
                        familyController.clear();
                        deskripsiController.clear();
                        penyemaianController.clear();
                        penanamanController.clear();
                        perawatanController.clear();
                        pemanenanController.clear();
                        penangananHamaController.clear();
                        rekomendasiPupukController.clear();
                        fileController.clear();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AllPlantAdminScreen()));
                      }
                    },
                    child: const Text("Edit")),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
