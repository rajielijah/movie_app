import 'package:flutter/material.dart';
import 'help_data.dart';
import 'movie_detail.dart';

void main() => runApp(MyMovie());

class MyMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  int moviesCount;
  List movies;
  HttpData helper;
  String getdata;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Future initialize() async {
    movies = List();
    movies = await helper.getMovie();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper.findMovie(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');

  @override
  void initState() {
    helper = HttpData();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      onSubmitted: (String text) {
                        search(text);
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    setState(() {
                      this.visibleIcon = Icon(Icons.search);
                      this.searchBar = Text('Movies');
                    });
                  }
                });
              })
        ],
      ),
      body: ListView.builder(
        itemCount: (this.moviesCount = null) ? 0 : this.moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position])));
                },
                leading: CircleAvatar(backgroundImage: image),
                title: Text(movies[position].title),
                subtitle: Text('Released: ' +
                    movies[position].releaseDate +
                    'Vote: ' +
                    movies[position].voteAverage.toString())),
          );
        },
      ),
    );
  }
}
