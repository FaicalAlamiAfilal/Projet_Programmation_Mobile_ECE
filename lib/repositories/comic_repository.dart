import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comic.dart';

class ComicRepository {
  final String api_key = '69286710c08e303689741960333d2da73eeac998';

  Future<Comic> fetchComic({required String apiDetailUrl}) async {
    final url = Uri.parse('$apiDetailUrl?api_key=$api_key&format=json&field_list=id,image,name,volume,issue_number,cover_date,character_credits,person_credits,api_detail_url,description');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Comic.fromJson(data['results']);
    } else {
      throw Exception('Failed to load. Status code: ${response.statusCode}');
    }
  }
}