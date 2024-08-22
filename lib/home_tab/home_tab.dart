import 'package:flutter/material.dart';
import 'content.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/venom-poster.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.play_circle_filled,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    width: 100,
                    height: 190,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/venom-poster.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 5,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_add_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ), 

          Content(
            title: 'New Releases',
            itemCount: 5,
            assetImagePath: 'assets/images/venom-poster.webp',
          ),
          Content(
            title: 'Recommended',
            itemCount: 5,
            assetImagePath: 'assets/images/venom-poster.webp',

          ),
        ],
      ),
    );
  }
  }


