import '../../domain/entities/entities.dart';

class RemoteMovieModel {
  final String name;
  final double popularity;

  const RemoteMovieModel({
    required this.name,
    required this.popularity,
  });

  factory RemoteMovieModel.fromJson(Map json) {
    return RemoteMovieModel(
      name: json["name"],
      popularity: double.tryParse(json["popularity"])!,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
        name: name,
      popularity: popularity,
    );
  }
}
