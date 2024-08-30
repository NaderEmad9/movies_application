class ApiConstant {
  ///https://api.themoviedb.org/3/movie/popular
  static const String scheme = "https";
  static const String host = 'api.themoviedb.org';
 static const String popularMoviespath = '/3/movie/popular';
  static const String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOTY2YjQ0Yjc0ZDlkZjA3ZDBjYjRmYjNhNzAyZDk0ZiIsIm5iZiI6MTcyNDY5MzQ2MS4wMzcyNzQsInN1YiI6IjY2YzNhMWUwODlhMTI5ZGJmNzZlM2NmYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.K_cli2oWxsRjYaiRYclJhflNgdDtbsPLLoNeHYsKigk';
  static const String newReleasesMoviespath = '/3/movie/upcoming';
  static const String topRatedMoviespath = '/3/movie/top_rated';
  static const String searchMoviepath = '/3/search/movie';
  static const String genreMoviepath = '/3/genre/movie/list';
  static const String discoverMoviepath = '/3/discover/movie';
  static String detailsMoviepath(int movieId) => '/3/movie/$movieId';
  static String similarMoviespath(int movieId) => '/3/movie/$movieId/similar';
}
