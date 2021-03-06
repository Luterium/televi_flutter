import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:televi_flutter/blocs/detailed_movie_bloc/bloc/bloc/detailed_movie_bloc.dart';
import 'package:televi_flutter/blocs/movie_bloc/movies_bloc.dart';
import 'package:televi_flutter/presentation/scenes/movie/movie_list/MovieList.dart';
import 'package:televi_flutter/data/repository/MoviesRepository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "Televi Flutter",
      home: Provider<MovieRepository>(
        create: (_) => MovieRepository(client: Client()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MoviesBloc>(create: (context) => MoviesBloc(movieRepository: Provider.of<MovieRepository>(context, listen: false))),
            BlocProvider<DetailedMovieBloc>(create: (context) => DetailedMovieBloc(movieRepository: Provider.of<MovieRepository>(context, listen: false)))
          ],
          child: MovieList(),
        )
      )
    );
  }
}