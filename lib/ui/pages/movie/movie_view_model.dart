class MovieViewModel {
  final String name;
  final String? imageUrl;
  final double popularity;
  final int likes;

  const MovieViewModel({
    required this.name,
    required this.imageUrl,
    required this.popularity,
    required this.likes,
  });
}
