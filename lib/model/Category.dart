import 'package:flutter/material.dart';

class Category{
  String id ;
  String name ;

  Category({required this.id , required this.name });

static List<Category> getCategory(){
  return [
    Category(id: 'action', name: 'Action'),
    Category(id: 'adventure', name: 'Adventure'),
    Category(id: 'animation', name: 'Animation'),
    Category(id: 'comedy', name: 'Comedy'),
    Category(id: 'documentary', name: 'Documentary'),
    Category(id: 'thriller', name: 'Thriller' ),
    Category(id: 'horror', name: 'Horror' ),

  ];
  
}
}