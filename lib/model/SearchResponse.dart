/// page : 1
/// results : [{"adult":false,"backdrop_path":"/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg","genre_ids":[28,878,12],"id":27205,"original_language":"en","original_title":"Inception","overview":"Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person's idea into a target's subconscious.","popularity":71.712,"poster_path":"/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg","release_date":"2010-07-15","title":"Inception","video":false,"vote_average":8.369,"vote_count":36158},{"adult":false,"backdrop_path":"/JeGkRdNsOuMrgwBdtB0hp763MU.jpg","genre_ids":[18,53],"id":613092,"original_language":"es","original_title":"El crack cero","overview":"Madrid, Spain, 1975; shortly after the end of the Franco dictatorship. Six months after the mysterious death of his lover, a prestigious tailor, a married woman visits the office of the young Germán Areta, a former police officer turned private detective, to request his professional services.","popularity":3.243,"poster_path":"/kzgPu2CMxBr4YZZxC1Off4cUfR9.jpg","release_date":"2019-10-04","title":"The Crack: Inception","video":false,"vote_average":6.6,"vote_count":37},{"adult":false,"backdrop_path":null,"genre_ids":[16,28,53,878],"id":64956,"original_language":"en","original_title":"Inception: The Cobol Job","overview":"This \"Inception\" prequel unfolds courtesy of a beautiful Motion Comic, and explains how Cobb, Arthur and Nash were enlisted by Cobol Engineering.","popularity":9.333,"poster_path":"/sNxqwtyHMNQwKWoFYDqcYTui5Ok.jpg","release_date":"2010-12-07","title":"Inception: The Cobol Job","video":false,"vote_average":7.263,"vote_count":302},{"adult":false,"backdrop_path":null,"genre_ids":[],"id":350632,"original_language":"en","original_title":"Nātyārambham","overview":"On certain Adavus: the basic steps in Bharatanatyam. The first part covers Tatta Adavu, Natta Adavu, Visharu Adavu , Tatti Metti Adavu and Teermanam Adavu.","popularity":1.573,"poster_path":null,"release_date":"","title":"The Inception of Dramatic Representation","video":true,"vote_average":5.8,"vote_count":3},{"adult":false,"backdrop_path":null,"genre_ids":[35],"id":542438,"original_language":"en","original_title":"Bikini Inception","overview":"Two flunky Janitors in an Arctic Lab perform unauthorized experiments transporting them to a beach dream world in Malibu California w/50 beautiful young girls and a female Brazilian PhD Student wearing only a bra and panties. A '67 Muscle car races chases horses guns fights surfing, sumo wrestler, wolf monster, underwater scenes tons of gorgeous models. Sexy sci-fi fun.","popularity":3.899,"poster_path":"/mNASlEOFX2c9upxaSbgeKFvIr1L.jpg","release_date":"2015-05-19","title":"Bikini Inception","video":false,"vote_average":7.0,"vote_count":1},{"adult":false,"backdrop_path":null,"genre_ids":[10402],"id":973484,"original_language":"en","original_title":"Inception: Music from the Motion Picture","overview":"The Special Features Blu-ray disc contains a lossless DTS-HD MA 5.1 surround mix of the Inception soundtrack.","popularity":2.166,"poster_path":"/7uM4DyRVAcgagvhZoWrkrqMPbqV.jpg","release_date":"2010-12-07","title":"Inception: Music from the Motion Picture","video":true,"vote_average":6.0,"vote_count":1},{"adult":false,"backdrop_path":null,"genre_ids":[],"id":250845,"original_language":"en","original_title":"WWA The Inception","overview":"The first World Wrestling Allstars pay per view, live from Sydney, Australia! A tournament titled \"7 Deadly Sins\", each round having a stipulation match, the winner will be crowned the first ever WWA Heavyweight Champion! Wrestlers such as Jeff Jarrett, Road Dogg, Jerry Lawler all compete in the tournament, with the WWA Commissioner, Bret Hart not too far away to make sure nothing gets to far out of hand!","popularity":1.124,"poster_path":null,"release_date":"2001-10-26","title":"WWA The Inception","video":true,"vote_average":3.1,"vote_count":5}]
/// total_pages : 1
/// total_results : 7

class SearchResponse {
  SearchResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.status,
    this.code,
    this.message,
  });

  SearchResponse.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Search.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  String? status;
  int? page;
  List<Search>? results;
  int? totalPages;
  int? totalResults;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}

/// adult : false
/// backdrop_path : "/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg"
/// genre_ids : [28,878,12]
/// id : 27205
/// original_language : "en"
/// original_title : "Inception"
/// overview : "Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person's idea into a target's subconscious."
/// popularity : 71.712
/// poster_path : "/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg"
/// release_date : "2010-07-15"
/// title : "Inception"
/// video : false
/// vote_average : 8.369
/// vote_count : 36158

class Search {
  Search({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Search.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}
