import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarttaniapp/models/plant_model.dart';

class PlantServices {
  Stream<List<Plant>> fetchPlant() => FirebaseFirestore.instance
      .collection('plant')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

  Future<void> createPlant(Plant plant) async {
    final docplant = FirebaseFirestore.instance.collection('plant').doc();
    plant.id = docplant.id;

    final json = plant.toJson();
    await docplant.set(json);
  }

  Future<void> updatePlant(Plant plant, String id) async {
    final docplant = FirebaseFirestore.instance.collection('plant').doc(id);
    docplant
        .update({
          'nama': plant.nama,
          'namaLatin': plant.namaLatin,
          'kingdom': plant.kingdom,
          'family': plant.family,
          'deskripsi': plant.deskripsi,
          'imageUrl': plant.imageUrl,
          'penyemaian': plant.penyemaian,
          'penanaman': plant.penanaman,
          'perawatan': plant.perawatan,
          'pemanenan': plant.pemanenan,
          'penangananHama': plant.penangananHama,
          'rekomendasiPupuk': plant.rekomendasiPupuk
        })
        // ignore: avoid_print
        .then((value) => print("User Updated"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deletePlant(String id) {
    final docplant = FirebaseFirestore.instance.collection('plant').doc(id);

    return docplant
        .delete()
        // ignore: avoid_print
        .then((value) => print("User Deleted"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
