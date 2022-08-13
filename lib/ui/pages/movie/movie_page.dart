import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/load_movie_bloc.dart';
import 'widgets/widgets.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _favoriteNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _favoriteNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: BlocBuilder<LoadMovieBloc, LoadMovieState>(
            builder: (context, state) {
              if (state is LoadMovieSuccess) {
                final movie = state.movie;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 400,
                      flexibleSpace: FlexibleSpaceBar(
                        background: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.easeOut,
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, _) {
                              print(value);
                              return Transform.scale(
                                scale: value,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    if (movie.imageUrl != null)
                                      Image.network(
                                        movie.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    const DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      )),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    movie.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  ValueListenableBuilder<bool>(
                                      valueListenable: _favoriteNotifier,
                                      builder: (context, isFavorite, _) {
                                        return IconButton(
                                          icon: Icon(isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border),
                                          onPressed: () {
                                            _favoriteNotifier.value =
                                                !_favoriteNotifier.value;
                                          },
                                        );
                                      }),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite, size: 20),
                                      const SizedBox(width: 5),
                                      Text("${movie.likes} curtidas",
                                          style: TextStyle(color: Colors.grey))
                                    ],
                                  ),
                                  const SizedBox(width: 25),
                                  Row(
                                    children: [
                                      const Icon(Icons.circle_outlined,
                                          size: 20),
                                      const SizedBox(width: 5),
                                      Text("${movie.popularity}",
                                          style: TextStyle(color: Colors.grey))
                                    ],
                                  )
                                ],
                              ),
                              const SimilarMovies(),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              }
              if (state is LoadMovieError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
