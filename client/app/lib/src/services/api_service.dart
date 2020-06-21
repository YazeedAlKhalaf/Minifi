import 'package:flutter/cupertino.dart';
import 'package:minifi_app/src/constants/config.dart';
import 'package:minifi_app/src/models/short_url.dart';
import 'package:http/http.dart';

class ApiService {
  final String baseUrl = BASE_URL;
  Client client = Client();

  Future<List<ShortUrl>> getShortUrls() async {
    final response = await client.get("$baseUrl/api/v1/shortUrl");
    if (response.statusCode == 200) {
      return ShortUrl.shortUrlsFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createShortUrl(String originalUrl) async {
    final String url = '$baseUrl/api/v1/shortUrl';
    final Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };
    final Map<String, dynamic> body = {
      "originalUrl": originalUrl,
    };
    final Response response = await client.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateShortUrl({
    @required ShortUrl shortUrl,
    @required String newOriginialUrl,
  }) async {
    final String url = '$baseUrl/api/v1/shortUrl/${shortUrl.shortUrl}';
    final Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };
    final Map<String, dynamic> body = {
      "originalUrl": newOriginialUrl,
    };
    final Response response = await put(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteShortUrl({
    @required ShortUrl shortUrl,
  }) async {
    final String url = '$baseUrl/api/v1/shortUrl/${shortUrl.shortUrl}';
    final Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };
    final Response response = await delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
