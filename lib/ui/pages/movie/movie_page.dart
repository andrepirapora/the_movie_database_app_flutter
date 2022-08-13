import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/load_movie_bloc.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

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
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie.imageUrl,
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
                                  const Icon(Icons.favorite),
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
                              SizedBox(
                                height: 900,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              }
              if (state is LoadMovieError) {
                return const Center(
                  child: Text("Um erro inesperado aconteceu :("),
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
