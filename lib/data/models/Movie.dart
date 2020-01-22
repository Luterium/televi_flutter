class Movie {
  int id;
  double voteAverage;
  String title;
  String imageURL;  

  Movie({this.id, this.voteAverage, this.title, this.imageURL});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      voteAverage: json["vote_average"],
      title: json["title"],
      imageURL: json["poster_url"]
    );
  }
}