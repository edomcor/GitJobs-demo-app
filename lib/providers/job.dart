import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Job with ChangeNotifier {
  final String id;
  final String url;
  final String title;
  final String type;
  final String description;
  final String location;
  final String company;
  final String companyUrl;
  final String howToApply;
  final String companyLogo;
  final String createdAt;

  bool isSaved;

  Job({
    @required this.id,
    this.type,
    this.url,
    this.title,
    this.description,
    this.location,
    this.company,
    this.companyLogo,
    this.companyUrl,
    this.howToApply,
    this.createdAt,
    this.isSaved = false,
  });

  void _toggleSave(bool newValue) {
    isSaved = newValue;
    notifyListeners();
  }

  Future<void> toggleSavedStatus(String authToken, String userId) async {
    final url =
        "https://githubjobsdemo.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken";

    final oldStatus = isSaved;
    isSaved = !isSaved;
    notifyListeners();

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isSaved,
        ),
      );
      if (response.statusCode >= 400) {
        _toggleSave(oldStatus);
      }
    } catch (error) {
      _toggleSave(oldStatus);
    }
  }
}
