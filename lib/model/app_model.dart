class Feed {
  String title;
  String id;
  Author author;
  List<Link> links;
  String copyright;
  String country;
  String icon;
  String updated;
  List<Result> results;

  Feed({
    required this.title,
    required this.id,
    required this.author,
    required this.links,
    required this.copyright,
    required this.country,
    required this.icon,
    required this.updated,
    required this.results,
  });

  // Ensure that all required fields are safely parsed
  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      title: json["title"] ?? "Unknown Title", // Default value if null
      id: json["id"] ?? "Unknown ID", // Default value if null
      author: json["author"] != null
          ? Author.fromJson(json["author"])
          : Author(name: "", url: ""), // Handle missing author
      links: json["links"] != null
          ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
          : [], // Handle missing links
      copyright:
          json["copyright"] ?? "Unknown Copyright", // Default value if null
      country: json["country"] ?? "Unknown Country", // Default value if null
      icon: json["icon"] ?? "", // Default value if null
      updated: json["updated"] ?? "", // Default value if null
      results: json["results"] != null
          ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
          : [], // Handle missing results
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "author": author.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "copyright": copyright,
        "country": country,
        "icon": icon,
        "updated": updated,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Author {
  String name;
  String url;

  Author({
    required this.name,
    required this.url,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json["name"] ?? "Unknown", // Default value if null
      url: json["url"] ?? "", // Default value if null
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Link {
  String self;

  Link({
    required this.self,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      self: json["self"] ?? "", // Default value if null
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

class Result {
  String artistName;
  String id;
  String name;
  DateTime releaseDate;
  Kind kind;
  String artworkUrl100;
  List<Genre> genres;
  String url;

  Result({
    required this.artistName,
    required this.id,
    required this.name,
    required this.releaseDate,
    required this.kind,
    required this.artworkUrl100,
    required this.genres,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      artistName:
          json["artistName"] ?? "Unknown Artist", // Default value if null
      id: json["id"] ?? "Unknown ID", // Default value if null
      name: json["name"] ?? "Unknown Name", // Default value if null
      releaseDate: json["releaseDate"] != null
          ? DateTime.parse(json["releaseDate"])
          : DateTime.now(), // Default value if null
      kind: kindValues.map[json["kind"]] ?? Kind.APPS, // Handle missing kind
      artworkUrl100: json["artworkUrl100"] ?? "", // Default value if null
      genres: json["genres"] != null
          ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
          : [], // Handle missing genres
      url: json["url"] ?? "", // Default value if null
    );
  }

  Map<String, dynamic> toJson() => {
        "artistName": artistName,
        "id": id,
        "name": name,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "kind": kindValues.reverse[kind],
        "artworkUrl100": artworkUrl100,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "url": url,
      };
}

class Genre {
  String genreId;
  String name;
  String url;

  Genre({
    required this.genreId,
    required this.name,
    required this.url,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreId: json["genreId"] ?? "Unknown Genre ID", // Default value if null
      name: json["name"] ?? "Unknown Genre", // Default value if null
      url: json["url"] ?? "", // Default value if null
    );
  }

  Map<String, dynamic> toJson() => {
        "genreId": genreId,
        "name": name,
        "url": url,
      };
}

enum Kind { APPS }

final kindValues = EnumValues({"apps": Kind.APPS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
