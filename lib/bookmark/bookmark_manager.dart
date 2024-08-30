import 'dart:convert';
import 'package:movies_application/model/Movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager {
  static const String _bookmarksKey = 'bookmarks';

  // Save a movie to bookmarks
  static Future<void> addBookmark(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    bookmarks.add(jsonEncode(movie.toJson())); // Convert Movie to JSON
    await prefs.setStringList(_bookmarksKey, bookmarks);
  }

  // Remove a movie from bookmarks
  static Future<void> removeBookmark(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    bookmarks.removeWhere((bookmarkJson) =>
        jsonDecode(bookmarkJson)['id'] == movie.id); // Ensure matching by ID
    await prefs.setStringList(_bookmarksKey, bookmarks);
  }

  // Get all bookmarked movies
  static Future<List<Movie>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    return bookmarks
        .map((bookmarkJson) => Movie.fromJson(jsonDecode(bookmarkJson)))
        .toList();
  }

  // Check if a movie is bookmarked
  static Future<bool> isBookmarked(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    return bookmarks.any((bookmarkJson) =>
        jsonDecode(bookmarkJson)['id'] == movie.id); // Ensure matching by ID
  }
}
