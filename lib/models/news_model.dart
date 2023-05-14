// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  String status;
  int totalResults;
  List<Result> results;
  String nextPage;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.results,
    required this.nextPage,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "nextPage": nextPage,
      };
}

class Result {
  String title;
  String link;
  List<String>? keywords;
  dynamic creator;
  dynamic videoUrl;
  String description;
  String? content;
  DateTime pubDate;
  String? imageUrl;
  String sourceId;
  List<String> category;
  List<Country> country;
  Language language;

  Result({
    required this.title,
    required this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    required this.description,
    this.content,
    required this.pubDate,
    this.imageUrl,
    required this.sourceId,
    required this.category,
    required this.country,
    required this.language,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        link: json["link"],
        keywords: json["keywords"] == null
            ? []
            : List<String>.from(json["keywords"]!.map((x) => x)),
        creator: json["creator"],
        videoUrl: json["video_url"],
        description: json["description"],
        content: json["content"],
        pubDate: DateTime.parse(json["pubDate"]),
        imageUrl: json["image_url"],
        sourceId: json["source_id"],
        category: List<String>.from(json["category"].map((x) => x)),
        country: List<Country>.from(
            json["country"].map((x) => countryValues.map[x]!)),
        language: languageValues.map[json["language"]]!,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "keywords":
            keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
        "creator": creator,
        "video_url": videoUrl,
        "description": description,
        "content": content,
        "pubDate": pubDate.toIso8601String(),
        "image_url": imageUrl,
        "source_id": sourceId,
        "category": List<dynamic>.from(category.map((x) => x)),
        "country":
            List<dynamic>.from(country.map((x) => countryValues.reverse[x])),
        "language": languageValues.reverse[language],
      };
}

enum Country { INDONESIA, HUNGARY }

final countryValues =
    EnumValues({"hungary": Country.HUNGARY, "indonesia": Country.INDONESIA});

enum Language { INDONESIAN, HUNGARIAN }

final languageValues = EnumValues(
    {"hungarian": Language.HUNGARIAN, "indonesian": Language.INDONESIAN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
