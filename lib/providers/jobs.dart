import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './job.dart';

class Jobs with ChangeNotifier {
  List<Job> _jobs = [];
  final String authToken;
  final String userId;

  Jobs(this.authToken, this.userId, this._jobs);

  List<Job> get jobs {
    return [..._jobs];
  }

  List<Job> get savedJobs {
    return _jobs.where((element) => element.isSaved == true).toList();
  }

  Future<void> fetchJobs([
    String description,
    String location,
  ]) async {
    var _baseUrl = "https://jobs.github.com";
    var _savedJobsUrl =
        "https://githubjobsdemo.firebaseio.com/userFavorites/$userId.json?auth=$authToken";

    try {
      final response = await http.get("$_baseUrl/positions.json?markdown=true");
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }

      final savedJobsResponse = await http.get(_savedJobsUrl);
      final savedJobs = json.decode(savedJobsResponse.body);
      print(json.decode(savedJobsResponse.body));
      final List<Job> loadedJobs = [];
      // print(json.decode(response.body));
      extractedData.forEach((element) {
        loadedJobs.add(Job(
          id: element["id"],
          title: element["title"],
          type: element["type"],
          url: element["url"],
          location: element["location"],
          company: element["company"],
          description: element["description"],
          createdAt: element["created_at"],
          companyLogo: element["company_logo"],
          isSaved: savedJobs[element["id"]] == null
              ? false
              : savedJobs[element["id"]],
        ));
      });
      _jobs = loadedJobs;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Job findById(String id) {
    return _jobs.firstWhere((element) => element.id == id);
  }
}
