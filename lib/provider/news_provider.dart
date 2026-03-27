import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  List news = [];
  bool isLoading = true;

  Future<void> fetchNews() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("https://api.worldnewsapi.com/search-news?text=india"),
        headers: {
          "x-api-key": "5ec3910735e34b3fb5047bb7b5ff6f9f",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        news = data['news'];
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}