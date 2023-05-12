import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarttaniapp/screens/news/view_model_news.dart';
import 'package:smarttaniapp/utils/constant/color.dart';
import 'package:smarttaniapp/utils/state/finite_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsScreen extends StatefulWidget {
  final String url;
  const DetailNewsScreen({super.key, required this.url});

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  WebViewController? _controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer<NewsProvider>(builder: (context, provider, _) {
        switch (provider.myState) {
          case MyState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case MyState.loaded:
            if ((provider.searchews).isEmpty) {
              return const Text("Data Masih Kosong");
            } else {
              return Stack(
                children: [
                  WebViewWidget(controller: _controller!),
                  if (loadingPercentage < 100)
                    LinearProgressIndicator(
                      value: loadingPercentage / 100.0,
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
              );
            }
          case MyState.failed:
            return const Text('Data gagal di load');
          default:
            return const SizedBox();
        }
      }),
    ));
  }
}
