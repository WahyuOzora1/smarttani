// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:smarttaniapp/models/news_model.dart';
// import 'package:smarttaniapp/models/plant_model.dart';
// import 'package:smarttaniapp/services/news_api.dart';
// import 'package:smarttaniapp/services/plant_api.dart';
// import 'package:smarttaniapp/state/finite_state.dart';

// class PlantProvider extends ChangeNotifier {
//   final PlantServices service = PlantServices();

//   Stream<List<Plant>> _plants;
//   Stream<List<Plant>> get plants => _plants;

//   MyState myState = MyState.loading;

//   Future fetchPlant() async {
//     try {
//       myState = MyState.loading;
//       notifyListeners();

//       _plants = await service.fetchPlant();

//       myState = MyState.loaded;
//       notifyListeners();
//     } catch (e) {
//       if (e is DioError) {
//         e.response!.statusCode;
//       }

//       myState = MyState.failed;
//       notifyListeners();
//     }
//   }
// }
