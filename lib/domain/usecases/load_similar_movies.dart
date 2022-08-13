import '../entities/entities.dart';

abstract class LoadSimilarMovies {
  Future<List<MovieEntity>> load();
}
