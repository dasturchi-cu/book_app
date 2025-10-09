import 'package:book_app/domain/entities/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> getGenres();
  Future<Genre> getGenreById(String id);
  Future<Genre> createGenre(String genreName);
  Future<Genre> updateGenre({
    required String id,
    required String genreName,
  });
  Future<void> deleteGenre(String id);
  Future<int> getGenreCount();
}