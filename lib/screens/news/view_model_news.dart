import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smarttaniapp/models/api/news_api.dart';
import 'package:smarttaniapp/models/news_model.dart';
import 'package:smarttaniapp/utils/state/finite_state.dart';

class NewsProvider extends ChangeNotifier {
  final NewsServices service = NewsServices();

  List<Result> _news = [];
  List<Result> get news => _news;

  List<Result> searchews = [];
  String searchText = '';

  MyState myState = MyState.loading;

  Future fetchNewsProvider() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      final response = await service.fetchNewsApi();
      _news = response.results;

      updateDataBySearch();
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        e.response!.statusCode;
      }

      myState = MyState.failed;
      notifyListeners();
    }
  }

  updateDataBySearch() async {
    searchews.clear();
    final response = await service.fetchNewsApi();

    try {
      myState = MyState.loading;
      notifyListeners();

      if (searchText.isEmpty) {
        searchews = response.results;
      } else {
        myState = MyState.loading;
        notifyListeners();
        searchews = response.results
            .where(
                (element) => element.title.toLowerCase().contains(searchText))
            .toList();
      }
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        e.response!.statusCode;
      }

      myState = MyState.failed;
      notifyListeners();
    }
  }

  search(String title) {
    searchText = title;
    updateDataBySearch();
  }
}
