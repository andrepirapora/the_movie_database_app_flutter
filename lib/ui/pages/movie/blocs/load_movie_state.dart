part of 'load_movie_bloc.dart';

@immutable
abstract class LoadMovieState {}

class LoadMovieInitial extends LoadMovieState {}

class LoadMovieSuccess extends LoadMovieState {
  final MovieViewModel movie;

  LoadMovieSuccess(this.movie);
}

class LoadMovieError extends LoadMovieState {
  final String error;

  LoadMovieError(this.error);
}
