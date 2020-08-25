import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedJob with ChangeNotifier {
  final String id;

  SavedJob(this.id);
}

class SavedJobs with ChangeNotifier {
  List<SavedJob> _savedJobs = [];
  final String authToken;
  final String userId;

  SavedJobs(this.authToken, this.userId, this._savedJobs);

  List<SavedJob> get jobs {
    return [..._savedJobs];
  }

  Future<void> fetchSavedJobs() async {
    final url =
        "https://githubjobsdemo.firebaseio.com/userFavorites/$userId.json?auth=$authToken";
    try {
      final response = await http.get(url);
      final List<SavedJob> loadedJobs = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((key, value) {
        if (value) {}
      });
      print(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
