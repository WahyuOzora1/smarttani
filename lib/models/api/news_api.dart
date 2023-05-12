import 'package:dio/dio.dart';
import 'package:smarttaniapp/models/news_model.dart';
import 'package:smarttaniapp/utils/constant/url.dart';

class NewsServices {
  final Dio _dio = Dio();

  Future<NewsModel> fetchNewsApi() async {
    try {
      final Response response = await _dio.get(Urls.baseUrl);

      final news = NewsModel.fromJson(response.data);

      // print("cek cek cek ===================== $news");
      return news;
    } catch (e) {
      if (e is DioError) {
        e.response!.statusCode;
        // print("datatatatatata ${e.response!.statusCode}");
      }
      rethrow;
    }
  }
}
