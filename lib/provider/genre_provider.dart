import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_application/api/api_constant.dart';

class GenreProvider {
  static final Map<int, String> _genreMap = {};

  static Future<void> fetchGenres() async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.genreMoviepath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> genres = jsonDecode(response.body)['genres'];
      for (var genre in genres) {
        _genreMap[genre['id']] = genre['name'];
      }
    } else {
      throw Exception('Failed to load genres');
    }
  }

  static String getGenreNameById(int id) {
    return _genreMap[id] ?? 'Unknown Genre';
  }
}
