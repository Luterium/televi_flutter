import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:televi_flutter/blocs/movie_bloc/bloc.dart';
import 'package:televi_flutter/blocs/movie_bloc/movies_bloc.dart';
import 'package:televi_flutter/blocs/movie_bloc/movies_event.dart';
import 'package:televi_flutter/data/models/Movie.dart';
import 'package:televi_flutter/presentation/scenes/movie/detailed_movie/DetailedMoviePage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:televi_flutter/presentation/common/Widgets.dart';

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _onTryAgain = new PublishSubject<void>();

  Stream<void> onTryAgain;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMovies(context);
  }

  @override
  void initState() {
    super.initState();
    fetchMovies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Televi Flutter"),
        backgroundColor: Colors.black54,
      ),
       body: Container(
         child: BlocListener<MoviesBloc, MoviesState>(
           listener: (context, state) {
           },
            child: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is MoviesLoading) {
                  return buildLoadingScreen();
                } else if (state is MoviesLoaded) {
                  return Container(
                    color: Colors.black87,
                    child: buildMoviesList(context, state.movieList)
                  );
                } else if(state is MoviesLoadingError) {
                  return buildMoviesError(context);
                }
                else {
                  return Container();
                }
              },
            ),
         ),
       ),
    );
  }
}

extension on _MovieListState {

  Widget buildMoviesError(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
          child: Text(
            "Tentar novamente",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black
            )),
          onPressed: () {
            _onTryAgain.add(null);
            fetchMovies(context);
          },
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Não foi possível carregar os filmes",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black
            )),
        )],
      ),
      )
    );
  }

  void fetchMovies(BuildContext context) {
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc.add(GetMovies());
  }
}

Widget buildMoviesList(BuildContext context, List<Movie> movieList) {
  return GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 0.70,
    children: new List<Container>.generate(movieList.length, (index) {
      return new Container(
        child: GestureDetector(
          child: movieContainer(movieList[index]),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<MoviesBloc>(context),
                  child: DetailedMoviePage(
                    movieID: movieList[index].id
                  ),
                ),
              )
            );
          },
        )
      );
    })
  );
}

Widget movieContainer(Movie movie) {
  return Padding(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Image(
                image: NetworkImage(movie.imageURL),
              ),
              Positioned(
                bottom: 4,
                right: 16,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 24,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.yellow
                      ),
                    )
                  ],
                  )
              )
            ],
          )
  );
        
}