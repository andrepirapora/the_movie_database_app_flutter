import '../entities/entities.dart';

abstract class LoadMovie {
  Future<MovieEntity> load();
}
