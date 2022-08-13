import 'package:http/http.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/http/http.dart';

String makeUrl(String path) => "https://api.themoviedb.org/3/movie/$path";

HttpAdapter makeClient() => HttpAdapter(client: Client());
LoadMovie makeLoadMovie() => RemoteLoadMovie(
    client: makeClient(), url: makeUrl("550?api_key=${"api_key_here"}"));
