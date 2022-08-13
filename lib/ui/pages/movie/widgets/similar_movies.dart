import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/load_similar_movies_bloc.dart';

class SimilarMovies extends StatelessWidget {
  const SimilarMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadSimilarMoviesBloc, LoadSimilarMoviesState>(
      builder: (context, state) {
        if (state is LoadSimilarMovieSuccess) {
          return ListView.builder(
              itemCount: state.movies.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return Row(
                  children: [
                    if (movie.imageUrl != null)
                      Image.network(
                        movie.imageUrl!,
                        height: 75,
                      ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${movie.likes} curtidas",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    )
                  ],
                );
              });
        }
        if (state is LoadSimilarMovieError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
