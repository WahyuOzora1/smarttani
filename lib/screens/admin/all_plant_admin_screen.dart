import 'package:flutter/material.dart';
import 'package:smarttaniapp/models/api/plant_api.dart';
import 'package:smarttaniapp/models/plant_model.dart';
import 'package:smarttaniapp/screens/admin/edit_plant_screen.dart';
import 'package:smarttaniapp/screens/admin/tambah_plant_screen.dart';
import 'package:smarttaniapp/screens/home_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/widgets/circular_indicator_widget.dart';

class AllPlantAdminScreen extends StatefulWidget {
  const AllPlantAdminScreen({super.key});

  @override
  State<AllPlantAdminScreen> createState() => _AllPlantAdminScreenState();
}

class _AllPlantAdminScreenState extends State<AllPlantAdminScreen> {
  PlantServices plantService = PlantServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Daftar tanaman"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Plant>>(
          stream: plantService.fetchPlant(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Something went wrong! ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final plants = snapshot.data!;
              // print("ada plants gal $plants");
              return ListView.builder(
                  itemCount: plants.length,
                  itemBuilder: ((context, index) {
                    final plant = plants[index];
                    // print("ada plant gak ${plant.nama}");
                    // print("ada plant deskripsi gak ${plant.deskripsi}");

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      EditPlantScreen(plant: plant)));
                        },
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            plantService.deletePlant(plant.id);
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Apakah kamu yakin mau menghapus?',
                                      style: TextStyle(
                                        fontSize: 13,
                                      )),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Tidak',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Iya',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    )
                                  ],
                                );
                              },
                            );
                            return confirmed;
                          },
                          key: UniqueKey(),
                          child: Container(
                            decoration: const BoxDecoration(color: formColor),
                            height: 150,
                            width: double.infinity,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: secondaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.network(
                                        plant.imageUrl ??
                                            "https://firebasestorage.googleapis.com/v0/b/wahyufirebase.appspot.com/o/images%2F1683627520154?alt=media&token=fdb375f1-ad77-450f-82e6-dcaf52c98c72",
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                              child:
                                                  circularProgressIndicator());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${plant.nama} (${plant.namaLatin})",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.justify,
                                          maxLines: 3,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("KINGDOM",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            221, 58, 57, 57))),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(plant.kingdom,
                                                    style: const TextStyle(
                                                        color: secondaryColor))
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Family",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            221, 58, 57, 57))),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(plant.family,
                                                    style: const TextStyle(
                                                        color: secondaryColor))
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "DESKRIPSI",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  221, 58, 57, 57)),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          plant.deskripsi,
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              color: secondaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
            } else {
              return Center(child: circularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const TambahPlantScreen()));
          },
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
