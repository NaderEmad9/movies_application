import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_application/model/DiscoverResponse.dart';
import 'package:movies_application/model/GenresResponse.dart';
import 'package:movies_application/model/NewReleaseResponse.dart';
import 'package:movies_application/model/PopularResponse.dart';
import 'package:movies_application/model/SearchResponse.dart';
import 'package:movies_application/model/TopRatedResponse.dart';
import 'api_constant.dart';

///https://api.themoviedb.org/3/movie/popular?api_key=28499bb843e6223bb89df9a57661cd222c

class ApiManager {
  static Future<PopularResponse?> getPopularMovies() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.popularMoviesApi,
        {'apiKey': ApiConstant.apiKey});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return PopularResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewReleaseResponse?> getNewReleasesMoviesApi() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.newReleasesMoviesApi,
        {'apiKey': ApiConstant.apiKey});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return NewReleaseResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<TopRatedResponse?> getTopRatedMoviesApi() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.topRatedMoviesApi,
        {'apiKey': ApiConstant.apiKey});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return TopRatedResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<SearchResponse?> getSearchMovieApi(String searchId) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.searchMovieApi,
        {'apiKey': ApiConstant.apiKey,
        'query': searchId
        });
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return SearchResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<GenresResponse?> getGenreMovieApi() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.genreMovieApi,
        {'apiKey': ApiConstant.apiKey});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return GenresResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<DiscoverResponse?> getDiscoverMovieApi() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.discoverMovieApi,
        {'apiKey': ApiConstant.apiKey});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //string
      var json = jsonDecode(responseBody); //json
      return DiscoverResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
