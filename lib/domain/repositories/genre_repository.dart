import 'package:book_app/domain/entities/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> getAllGenres();
  Future<Genre> getGenreById(String id);
  Future<List<Genre>> searchGenres(String query);
}
