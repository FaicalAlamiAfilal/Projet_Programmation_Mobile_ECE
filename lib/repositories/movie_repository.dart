import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieRepository {
  final String api_key = '69286710c08e303689741960333d2da73eeac998';

  Future<Movie> fetchMovie({required String apiUrl}) async {
    final url = Uri.parse('$apiUrl?api_key=$api_key&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data['results']);
    } else {
      throw Exception('Failed to load movie. Status code: ${response.statusCode}');
    }
  }
}

