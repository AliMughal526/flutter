import 'dart:convert';
import 'package:http/http.dart' as http;
import 'grade.dart';

class ApiService {
  static const String apiUrl = "https://bgnuerp.online/api/gradeapi";

  static Future<List<Grade>> fetchGrades() async {
    try {
      // Ensure the URL is parsed correctly and request is made
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Decode the response body
        List<dynamic> data = jsonDecode(response.body);

        // Check if the response is a list of objects and map to Grade objects
        return data.map((json) => Grade.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load grades: ${response.statusCode}");
      }
    } catch (e) {
      // Log the error and rethrow a detailed message
      print("Error: $e");
      throw Exception("Error fetching grades: $e");
    }
  }
}

