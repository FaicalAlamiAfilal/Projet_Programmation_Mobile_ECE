import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comics.dart';

class ComicsRepository {
  final String _baseUrl = 'https://comicvine.gamespot.com/api';
  final String api_key = '69286710c08e303689741960333d2da73eeac998';

  Future<List<Comics>> fetchComics({int limit = 10}) async {
    final url = Uri.parse('$_baseUrl/issues?api_key=$api_key&format=json&limit=$limit&offset=10&field_list=id,image,name,volume,issue_number,cover_date,api_detail_url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Comics.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load. Status code: ${response.statusCode}');
    }
  }

  Future<List<Comics>> searchComics(String query) async {
    final url = Uri.parse('$_baseUrl/search?api_key=$api_key&format=json&resources=issue&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Comics.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search');
    }
  }
}
