class Movie {
  int id;
  String title;
  String voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview, this.posterPath);
  Movie.fromJson(Map<String, dynamic> parsedJson){
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.releaseDate = parsedJson['releaseDate'];
    this.voteAverage = parsedJson['voteAverage'] * 1.0;
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['posterPath'];
  }
}