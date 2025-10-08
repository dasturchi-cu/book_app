import 'package:book_app/domain/entities/rating.dart';

abstract class RatingRepository {
  Future<List<Rating>> getAllRatings();
  Future<List<Rating>> getRatingsByBook(String bookId);
  Future<List<Rating>> getRatingsByUser(String userId);
  Future<Rating> createRating(String bookId, double rating, String? review);
  Future<Rating> updateRating(String id, double rating, String? review);
  Future<void> deleteRating(String id);
  Future<double> getAverageRating(String bookId);
}
