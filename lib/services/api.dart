import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:practical/model/app_model.dart';

class Apihalper {
  Apihalper._();

  static Apihalper apihalper = Apihalper._();

  Future<Feed?> getData() async {
    log("API Method is called...");
    Uri url = Uri.parse(
      "https://rss.marketingtools.apple.com/api/v2/us/apps/top-free/50/apps.json",
    );

    try {
      // Send GET request to the URL
      http.Response res = await http.get(url);

      if (res.statusCode == 200) {
        // Parse the JSON data
        Map<String, dynamic> data = jsonDecode(res.body);

        // Return the Feed object parsed from JSON
        return Feed.fromJson(data);
      } else {
        // Handle if the status code is not 200 (OK)
        log("Failed to load data, status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      // Log any errors during the request
      log("Error while fetching data: $e");
      return null;
    }
  }
}
