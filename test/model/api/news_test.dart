import 'package:flutter_test/flutter_test.dart';
import 'package:smarttaniapp/models/api/news_api.dart';

void main() {
  group('NewsApi', () {
    test('Get All News Returns Data', () async {
      var response = await NewsServices().fetchNewsApi();
      final news = response.results;

      expect(news.isNotEmpty, true);
    });
  });
}
