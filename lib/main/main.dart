import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/ui/pages/movie/movie.dart';

import '../ui/pages/movie/blocs/load_movie_bloc.dart';
import '../ui/pages/movie/blocs/load_similar_movies_bloc.dart';
import 'factories/usecases/usecases.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Movie DB",
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoadMovieBloc(
              loadMovie: makeLoadMovie(),
            )..add(LoadingMovieEvent()),
          ),
          BlocProvider(
            create: (context) => LoadSimilarMoviesBloc(
              similarMovies: makeLoadSimilarMovies(),
            )..add(LoadingSimilarMoviesEvent()),
          ),
        ],
        child: const MoviePage(),
      ),
    );
  }
}
