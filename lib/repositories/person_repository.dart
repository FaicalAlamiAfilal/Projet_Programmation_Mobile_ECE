import '../models/person.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonRepository {
  final String api_key = '69286710c08e303689741960333d2da73eeac998';

  Future<List<Person>> fetchPersons({int limit = 10, int offset = 0}) async {
    final url = Uri.parse(
        'https://comicvine.gamespot.com/api/people?api_key=$api_key&format=json&limit=$limit&offset=$offset');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load. Status code: ${response.statusCode}');
    }
  }

Future<List<Person>> fetchPersonsDetails(List<Person> persons) async {
    final List<Future<Person>> futures = persons.map((person) async {
      final url = Uri.parse(
          '${person.apiDetailUrl}?api_key=$api_key&format=json&field_list=image');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        person.updateFromJson(data['results']);
        return person;
      } else {
        throw Exception('Failed to load. Status code: ${response.statusCode}');
      }
    }).toList();

    return Future.wait(futures);
  }

  Future<List<Person>> searchPersons(String query) async {
    final url = Uri.parse(
        'https://comicvine.gamespot.com/api/search?api_key=$api_key&format=json&resources=person&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search.');
    }
  }
}