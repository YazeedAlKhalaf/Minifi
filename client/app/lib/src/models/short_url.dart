import 'dart:convert';

import 'package:string_validator/string_validator.dart';

class ShortUrl {
  final String id;
  final String originalUrl;
  final String shortUrl;
  final int clicksNumber;

  ShortUrl({
    this.id,
    this.originalUrl,
    this.shortUrl,
    this.clicksNumber,
  });

  factory ShortUrl.fromJson(Map<String, dynamic> map) {
    return ShortUrl(
      id: map['_id'],
      originalUrl: map['originalUrl'],
      shortUrl: map['shortUrl'],
      clicksNumber: map['clicksNumber'],
    );
  }

  static List<ShortUrl> shortUrlsFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<ShortUrl>.from(
      data.map(
        (shortUrl) => ShortUrl.fromJson(shortUrl),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': this.id,
      'originalUrl': this.originalUrl,
      'shortUrl': this.shortUrl,
      'clicksNumber': this.clicksNumber,
    };
  }
}
