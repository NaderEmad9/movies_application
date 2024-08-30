import 'package:flutter/material.dart';

import '../model/favourite_movie.dart';

class FavouriteMovieProvider extends ChangeNotifier {
  final List<FavouriteMovie> _favourites = [];

  List<FavouriteMovie> getFavourites() {
    return _favourites;
  }

  void addFavourite(FavouriteMovie movie) {
    _favourites.add(movie);
    notifyListeners();
  }

  void removeFavourite(FavouriteMovie movie) {
    _favourites.remove(movie);
    notifyListeners();
  }

  bool isFavourite(FavouriteMovie movie) {
    return _favourites.contains(movie);
  }
}
