import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarttaniapp/models/api/plant_api.dart';
import 'package:smarttaniapp/models/plant_model.dart';
import 'package:smarttaniapp/screens/login_screen.dart';
import 'package:smarttaniapp/screens/news/all_news_screen.dart';
import 'package:smarttaniapp/screens/news/detail_news_screen.dart';
import 'package:smarttaniapp/screens/news/view_model_news.dart';
import 'package:smarttaniapp/screens/plant/all_plant_screen.dart';
import 'package:smarttaniapp/screens/plant/detail_plant_screen.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/constant/url.dart';
import 'package:smarttaniapp/utils/state/finite_state.dart';
import 'package:smarttaniapp/utils/widgets/circular_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _data = const [
    MyHomePage(),
    LoginnScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _data.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: primaryColor,
          onTap: _onItemTapped,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List imageList = [
    'assets/images/3.jpg',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/4.jpeg',
    'assets/images/5.jpg',
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  num position = 1;
  PlantServices plantService = PlantServices();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final provider = Provider.of<NewsProvider>(context, listen: false);

        // print("Isi provider ini apaaaa : $provider");
        provider.fetchNewsProvider();
        // print(
        //     "Isi provider fetch ini apaaaa : ${provider.fetchNewsProvider()}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                CarouselSlider(
                  items: imageList
                      .map((e) => Image.asset(
                            e,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pilih Tanaman", style: TextStyle(fontSize: 14)),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AllPlantScreen()));
                      },
                      child: const Text("Lihat Semua",
                          style:
                              TextStyle(fontSize: 12, color: secondaryColor))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: StreamBuilder<List<Plant>>(
                stream: plantService.fetchPlant(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Something went wrong! ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final plants = snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: ((context, index) {
                        final plant = plants[index];
                        return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailProdukScreen(
                                          plant: plant,
                                        )));
                          }),
                          child: Card(
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        plant.imageUrl ?? Urls.noImageUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    plant.nama,
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Center(child: circularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Berita Terkini",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AllNewsScreen()));
                      },
                      child: const Text("Lihat Semua",
                          style:
                              TextStyle(fontSize: 12, color: secondaryColor))),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: Consumer<NewsProvider>(builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return Center(
                      child: circularProgressIndicator(),
                    );
                  case MyState.loaded:
                    if ((provider.news).isEmpty) {
                      return const Text("Data Masih Kosong");
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: provider.searchews.length,
                          itemBuilder: (BuildContext context, int index) {
                            final news = provider.searchews[index];
                            // print("isisisi dari news $news");
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailNewsScreen(
                                                url: news.link,
                                              )));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  height: 90,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        news.imageUrl ?? Urls.noImageUrl,
                                        height: 90,
                                        width: 120,
                                        fit: BoxFit.fill,
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
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                news.title,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                DateFormat(
                                                  'MMM d, yyyy h:mm a',
                                                )
                                                    .format(news.pubDate)
                                                    .toString(),
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
                            );
                          });
                    }
                  case MyState.failed:
                    return const Text('Data gagal di load');
                  default:
                    return const SizedBox();
                }
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
