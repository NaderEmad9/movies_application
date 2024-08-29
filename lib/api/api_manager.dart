import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_application/model/DiscoverResponse.dart';
import 'package:movies_application/model/GenresResponse.dart';
import 'package:movies_application/model/NewReleaseResponse.dart';
import 'package:movies_application/model/PopularResponse.dart';
import 'package:movies_application/model/SearchResponse.dart';
import 'package:movies_application/model/TopRatedResponse.dart';
import 'package:movies_application/model/MoviesSimilarResponse.dart';
import 'package:movies_application/model/MovieDetailsResponse.dart';
import 'api_constant.dart';

///https://api.themoviedb.org/3/movie/popular?api_key=28499bb843e6223bb89df9a57661cd222c
class HttpResponse<T> {
  final T data;
  final int statusCode;
  HttpResponse(this.data, this.statusCode);
}

class ApiManager {
  static Future<HttpResponse<PopularResponse>> getPopularMovies() async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.popularMoviespath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var popularResponse = PopularResponse.fromJson(json);
      return HttpResponse(popularResponse, status);
    } catch (e) {
      return HttpResponse(PopularResponse(), 500);
    }
  }

  static Future<HttpResponse<NewReleaseResponse>>
      getNewReleasesMoviesApi() async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.newReleasesMoviespath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var newReleaseResponse = NewReleaseResponse.fromJson(json);
      return HttpResponse(newReleaseResponse, status);
    } catch (e) {
      return HttpResponse(NewReleaseResponse(), 500);
    }
  }

  static Future<HttpResponse<TopRatedResponse>> getTopRatedMoviesApi() async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.topRatedMoviespath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var topRatedResponse = TopRatedResponse.fromJson(json);
      return HttpResponse(topRatedResponse, status);
    } catch (e) {
      return HttpResponse(TopRatedResponse(), 500);
    }
  }

  static Future<HttpResponse<SearchResponse>> getSearchMovieApi(
      String searchId) async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.searchMoviepath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var searchResponse = SearchResponse.fromJson(json);
      return HttpResponse(searchResponse, status);
    } catch (e) {
      return HttpResponse(SearchResponse(), 500);
    }
  }

  static Future<HttpResponse<GenresResponse>> getGenreMovieApi() async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.genreMoviepath);
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;

    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var genresResponse = GenresResponse.fromJson(json);
      return HttpResponse(genresResponse, status);
    } catch (e) {
      return HttpResponse(GenresResponse(), 500);
    }
  }

  static Future<HttpResponse<DiscoverResponse>> getDiscoverMovieApi(
      Object genreid, Object page) async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.discoverMoviepath,
        queryParameters: {
          'include_adult': 'true',
          'include_video': 'true',
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'popularity.desc',
          'with_genres': genreid.toString()
        });
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var discoverResponse = DiscoverResponse.fromJson(json);
      return HttpResponse(discoverResponse, status);
    } catch (e) {
      return HttpResponse(DiscoverResponse(), 500);
    }
  }

  static Future<HttpResponse<MovieDetailsResponse>> getDetailsMovieApi(
      int movieId) async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.detailsMoviepath(movieId));
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var movieDetailsrResponse = MovieDetailsResponse.fromJson(json);
      return HttpResponse(movieDetailsrResponse, status);
    } catch (e) {
      return HttpResponse(MovieDetailsResponse(), 500);
    }
  }

  static Future<HttpResponse<MoviesSimilarResponse>> getSimilarMoviesApi(
      int movieId) async {
    Uri url = Uri(
        scheme: ApiConstant.scheme,
        host: ApiConstant.host,
        path: ApiConstant.similarMoviespath(movieId));
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${ApiConstant.token}',
      "accept": 'application/json',
    });
    int status = response.statusCode;
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var moviesSimilarResponse = MoviesSimilarResponse.fromJson(json);
      return HttpResponse(moviesSimilarResponse, status);
    } catch (e) {
      return HttpResponse(MoviesSimilarResponse(), 500);
    }
  }
}
