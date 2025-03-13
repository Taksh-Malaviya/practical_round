import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:practical/model/app_model.dart';

class Apihalper {
  Apihalper._();

  static Apihalper apihalper = Apihalper._();

  Future<MyFeedData?> getData() async {
    log("API Method is called...");
    Uri url = Uri.parse(
      "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/50/apps.json",
    );

    try {
      http.Response res = await http.get(url);

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);

        log("Successfully load data, status code: ${res.statusCode}");

        log("Result : ${data['feed']['results'].length}");

        return MyFeedData.fromJson(data);
      } else {
        log("Failed to load data, status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error while fetching data: $e");
      return null;
    }
  }
}
