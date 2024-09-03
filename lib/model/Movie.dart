import 'package:movies_application/model/DiscoverResponse.dart';

class Movie {
  final String? id;
  final String? title;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage; // Add this property

  Movie({
    this.id,
    this.title,
    this.posterPath,
    this.releaseDate,
    this.voteAverage, // Add this property
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage:
          (json['vote_average'] as num?)?.toDouble(), // Add this property
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage, // Add this property
    };
  }

  factory Movie.fromDiscover(Discover discover) {
    return Movie(
      id: discover.id.toString(),
      title: discover.title,
      posterPath: discover.posterPath,
      releaseDate: discover.releaseDate,
      voteAverage: discover.voteAverage, // Add this property
    );
  }
}
