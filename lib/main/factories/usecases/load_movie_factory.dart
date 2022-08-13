import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import 'usecases.dart';

LoadMovie makeLoadMovie() => RemoteLoadMovie(
    client: makeClient(), url: makeUrl("550?api_key=${"api_key_here"}"));
