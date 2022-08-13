import '../../domain/entities/entities.dart';

class RemoteMovieModel {
  final String name;
  final String? imageUrl;
  final double popularity;
  final int likes;

  const RemoteMovieModel({
    required this.name,
    required this.imageUrl,
    required this.popularity,
    required this.likes,
  });

  factory RemoteMovieModel.fromJson(Map json) {
    return RemoteMovieModel(
      name: json["title"],
      imageUrl: json["backdrop_path"],
      popularity: json["popularity"],
      likes: json["vote_count"],
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      name: name,
      imageUrl: imageUrl,
      popularity: popularity,
      likes: likes,
    );
  }
}
