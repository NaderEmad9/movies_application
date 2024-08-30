import 'package:flutter/material.dart';
import 'package:movies_application/bookmark/bookmark_manager.dart';
import 'package:movies_application/model/Movie.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Movie> _bookmarkedMovies = [];

  List<Movie> get bookmarkedMovies => _bookmarkedMovies;

  BookmarkProvider() {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    _bookmarkedMovies = await BookmarkManager.getBookmarks();
    notifyListeners();
  }

  Future<void> addBookmark(Movie movie) async {
    await BookmarkManager.addBookmark(movie);
    _bookmarkedMovies.add(movie);
    notifyListeners();
  }

  Future<void> removeBookmark(Movie movie) async {
    await BookmarkManager.removeBookmark(movie);
    _bookmarkedMovies.removeWhere((m) => m.id == movie.id);
    notifyListeners();
  }

  Future<bool> isBookmarked(Movie movie) async {
    return await BookmarkManager.isBookmarked(movie);
  }
}
