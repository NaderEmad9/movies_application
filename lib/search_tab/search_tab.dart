import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/model/Movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/search_tab/movie_list.dart';
import 'package:movies_application/search_tab/no_movie.dart';
import 'package:movies_application/search_tab/search_input.dart';
import '../ui/app_colors.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool hasSearched = false;
  String searchQuery = '';
  List<Movie> searchResults = [];
  bool isLoading = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searching = AppLocalizations.of(context)!.searching;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: AppColors.blackColor.withOpacity(0.8),
        surfaceTintColor: Colors.transparent,
        title: SearchInputField(
          onChanged: _onSearchChanged,
          hintText: searching,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const CircularProgressIndicator(
                      color: AppColors.whiteColor),
            )
          : hasSearched
              ? searchResults.isNotEmpty
                  ? MovieList(searchResults: searchResults)
                  : const NoMoviesFound()
              : const NoMoviesFound(),
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchQuery = value;
        hasSearched = value.isNotEmpty;
        if (hasSearched) {
          fetchMovies(value);
        }
      });
    });
  }

  Future<void> fetchMovies(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiManager.getSearchMovieApi(query);

      if (response.statusCode == 200) {
        final data = response.data.toJson();
        final List<Movie> movies = (data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();

        setState(() {
          searchResults = movies;
          isLoading = false;
        });
      } else {
        setState(() {
          searchResults = [];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to fetch movies. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        searchResults = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching movies: $e')),
      );
    }
  }
}
