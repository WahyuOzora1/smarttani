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
  List<Keyword> keywords;
  List<String>? creator;
  dynamic videoUrl;
  String description;
  String? content;
  DateTime pubDate;
  String? imageUrl;
  SourceId sourceId;
  List<Category> category;
  List<Country> country;
  Language language;

  Result({
    required this.title,
    required this.link,
    required this.keywords,
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
        keywords: List<Keyword>.from(
            json["keywords"].map((x) => keywordValues.map[x]!)),
        creator: json["creator"] == null
            ? []
            : List<String>.from(json["creator"]!.map((x) => x)),
        videoUrl: json["video_url"],
        description: json["description"],
        content: json["content"],
        pubDate: DateTime.parse(json["pubDate"]),
        imageUrl: json["image_url"],
        sourceId: sourceIdValues.map[json["source_id"]]!,
        category: List<Category>.from(
            json["category"].map((x) => categoryValues.map[x]!)),
        country: List<Country>.from(
            json["country"].map((x) => countryValues.map[x]!)),
        language: languageValues.map[json["language"]]!,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "keywords":
            List<dynamic>.from(keywords.map((x) => keywordValues.reverse[x])),
        "creator":
            creator == null ? [] : List<dynamic>.from(creator!.map((x) => x)),
        "video_url": videoUrl,
        "description": description,
        "content": content,
        "pubDate": pubDate.toIso8601String(),
        "image_url": imageUrl,
        "source_id": sourceIdValues.reverse[sourceId],
        "category":
            List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
        "country":
            List<dynamic>.from(country.map((x) => countryValues.reverse[x])),
        "language": languageValues.reverse[language],
      };
}

// ignore: constant_identifier_names
enum Category { TOP, ENTERTAINMENT }

final categoryValues =
    EnumValues({"entertainment": Category.ENTERTAINMENT, "top": Category.TOP});

// ignore: constant_identifier_names
enum Country { INDONESIA }

final countryValues = EnumValues({"indonesia": Country.INDONESIA});

// ignore: constant_identifier_names
enum Keyword { HOT, LIFESTYLE, ASIA_PASIFIK }

final keywordValues = EnumValues({
  "Asia Pasifik": Keyword.ASIA_PASIFIK,
  "Hot": Keyword.HOT,
  "Lifestyle": Keyword.LIFESTYLE
});

// ignore: constant_identifier_names
enum Language { INDONESIAN }

final languageValues = EnumValues({"indonesian": Language.INDONESIAN});

// ignore: constant_identifier_names
enum SourceId { LIPUTAN6, REPUBLIKAIN }

final sourceIdValues = EnumValues(
    {"liputan6": SourceId.LIPUTAN6, "republikain": SourceId.REPUBLIKAIN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
