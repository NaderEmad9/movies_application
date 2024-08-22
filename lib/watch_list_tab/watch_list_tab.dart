import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/ui/app_colors.dart';

class WatchListTab extends StatefulWidget {
  const WatchListTab({super.key});

  @override
  WatchListTabState createState() => WatchListTabState();
}

class WatchListTabState extends State<WatchListTab> {
  late Future<List<Map<String, dynamic>>> itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = Future.value(mockItems());
  }

  List<Map<String, dynamic>> mockItems() {
    return [
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
      {
        'imageUrl': 'https://via.placeholder.com/650/',
        'title': 'Title',
        'description': 'The description for movie here.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var watchList = AppLocalizations.of(context)!.watchlist;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          watchList,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
        backgroundColor: AppColors.blackColor.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator()
                          : const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return buildListItem(
                        imageUrl: item['imageUrl'] as String,
                        title: item['title'] as String,
                        description: item['description'] as String,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.network(imageUrl,
                  width: 130, height: 100, fit: BoxFit.cover),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(description,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.lightGreyColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            height: 20,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
