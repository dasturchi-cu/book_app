import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/rating.dart';
import 'package:book_app/domain/repositories/rating_repository.dart';
import 'package:book_app/data/models/rating_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class RatingRepositoryImpl implements RatingRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<Rating>> getAllRatings() async {
    try {
      final response = await _dio.get(ApiEndpoints.ratings);
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => RatingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get ratings: $e');
    }
  }

  @override
  Future<List<Rating>> getRatingsByBook(String bookId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.ratings,
        queryParameters: {'bookId': bookId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => RatingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get ratings for book: $e');
    }
  }

  @override
  Future<List<Rating>> getRatingsByUser(String userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.ratings,
        queryParameters: {'userId': userId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => RatingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get ratings for user: $e');
    }
  }

  @override
  Future<Rating> createRating(String bookId, double rating, String? review) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createRating,
        data: {
          'bookId': bookId,
          'rating': rating,
          'review': review,
        },
      );
      
      return RatingModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to create rating: $e');
    }
  }

  @override
  Future<Rating> updateRating(String id, double rating, String? review) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateRating.replaceAll('{id}', id),
        data: {
          'rating': rating,
          'review': review,
        },
      );
      
      return RatingModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to update rating: $e');
    }
  }

  @override
  Future<void> deleteRating(String id) async {
    try {
      await _dio.delete(
        ApiEndpoints.deleteRating.replaceAll('{id}', id),
      );
    } catch (e) {
      throw Exception('Failed to delete rating: $e');
    }
  }

  @override
  Future<double> getAverageRating(String bookId) async {
    try {
      final ratings = await getRatingsByBook(bookId);
      if (ratings.isEmpty) return 0.0;
      
      final sum = ratings.fold<double>(0.0, (sum, rating) => sum + rating.rating);
      return sum / ratings.length;
    } catch (e) {
      return 0.0;
    }
  }
}
