import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/series.dart';

class SeriesRepository {
  final String _baseUrl = 'https://comicvine.gamespot.com/api';
  final String api_key = '69286710c08e303689741960333d2da73eeac998';

  Future<List<Series>> fetchSeries({int limit = 10}) async {
    final url = Uri.parse('$_baseUrl/series_list?api_key=$api_key&format=json&limit=$limit&offset=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Series.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load. Status code: ${response.statusCode}');
    }
  }

  Future<List<Series>> searchSeries(String query) async {
    final url = Uri.parse('$_baseUrl/search?api_key=$api_key&format=json&resources=series&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Series.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search');
    }
  }
}
