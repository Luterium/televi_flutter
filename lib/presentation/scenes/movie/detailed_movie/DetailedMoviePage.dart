import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:televi_flutter/blocs/detailed_movie_bloc/bloc/bloc/bloc.dart';
import 'package:televi_flutter/data/models/DetailedMovie.dart';
import 'package:televi_flutter/presentation/common/Widgets.dart';

class DetailedMoviePage extends StatefulWidget {
  final int movieID;

  const DetailedMoviePage({
    Key key,
    @required this.movieID
  }) : super(key: key);

  @override
  _DetailedMoviePageState createState() => _DetailedMoviePageState();
}

class _DetailedMoviePageState extends State<DetailedMoviePage> {
  String _movieName = "";
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<DetailedMovieBloc>(context)
      ..add(GetDetailedMovie(movieID: widget.movieID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieName),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        child: BlocListener<DetailedMovieBloc, DetailedMovieState>(
          listener: (context, state) {
          },
          child: BlocBuilder<DetailedMovieBloc, DetailedMovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                  return buildLoadingScreen();
                } else if (state is MovieLoaded) {
                  return Container(
                    height: double.infinity,
                    color: Colors.black87,
                    child: buildDetailedMovie(context, state.movie)
                  );
                } else if(state is MovieLoadingError) {
                  return buildMovieError(context, widget.movieID);
                }
            },
          )
        ),
      ),
    );
  }
}

Widget buildDetailedMovie(BuildContext context, DetailedMovie movie) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Image(
            image: NetworkImage(movie.imageURL),
          ),
        ),
        Center(
          child: Text(
            movie.title,
            style: TextStyle(
              fontSize: 32,
              color: Colors.white
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            movie.overview,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "${movie.runtime} minutos",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70
              )
            ),
            Text(
              movie.genres.join(', '),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70
              )
            )
          ],
        )
      ],
    ),
  );
}

Widget buildMovieError(BuildContext context, int movieID) {
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
          BlocProvider.of<DetailedMovieBloc>(context)..add(GetDetailedMovie(movieID: movieID));
        },
        color: Colors.grey,
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          "Não foi possível carregar o filme",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          )),
      )],
    ),
    )
  );
}