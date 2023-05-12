import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarttaniapp/screens/news/detail_news_screen.dart';
import 'package:smarttaniapp/screens/news/view_model_news.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/constant/url.dart';
import 'package:smarttaniapp/utils/state/finite_state.dart';
import 'package:smarttaniapp/utils/widgets/circular_indicator_widget.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  height: 218,
                  child: Image.asset(
                    'assets/images/search.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 8,
                    left: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, right: 10, left: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          provider.search(value);
                        },
                        cursorColor: primaryColor,
                        decoration: const InputDecoration(
                            hintText: 'Search',
                            suffixIcon: Icon(
                              Icons.search,
                              color: primaryColor,
                            ),
                            fillColor: Color(0xfff3f3f4),
                            labelStyle: TextStyle(color: Colors.black45),
                            filled: true,
                            focusColor: primaryColor,
                            hoverColor: primaryColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            )),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child:
                  Consumer<NewsProvider>(builder: (context, newsProvider, _) {
                switch (newsProvider.myState) {
                  case MyState.loading:
                    return Center(
                      child: circularProgressIndicator(),
                    );
                  case MyState.loaded:
                    if ((newsProvider.searchews).isEmpty) {
                      return const Center(child: Text("Data tidak ada"));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: newsProvider.searchews.length,
                          itemBuilder: (BuildContext context, int index) {
                            final news = newsProvider.searchews[index];
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
          ],
        ),
      ),
    );
  }
}
