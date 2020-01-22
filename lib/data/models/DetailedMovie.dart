class DetailedMovie {
  int id;
  double voteAverage;
  String title;
  String imageURL;
  List<String> genres;
  String overview;
  int runtime;

  DetailedMovie({this.id, this.voteAverage, this.title, this.imageURL, this.genres, this.overview, this.runtime});

  factory DetailedMovie.fromJson(Map<String, dynamic> json) {
    return DetailedMovie(
      id: json["id"],
      voteAverage: json["vote_average"],
      title: json["title"],
      imageURL: json["backdrop_url"],
      genres: List<String>.from(json["genres"]),
      overview: json["overview"],
      runtime: json["runtime"]
    );
  }
}