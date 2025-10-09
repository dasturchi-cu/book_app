import 'package:book_app/domain/entities/event.dart';
import 'package:book_app/domain/repositories/event_repository.dart';
import 'package:book_app/data/datasources/event_api_service.dart';
import 'package:book_app/data/models/event_model.dart';
import 'package:book_app/core/errors/app_exceptions.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiService _apiService;

  EventRepositoryImpl({required EventApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Event>> getEvents() async {
    try {
      final eventModels = await _apiService.getEvents();
      return eventModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch events: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching events: $e');
    }
  }

  @override
  Future<Event> getEventById(String id) async {
    try {
      final eventModel = await _apiService.getEventById(int.parse(id));
      return eventModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch event: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching event: $e');
    }
  }

  @override
  Future<Event> createEvent({
    required String name,
    required String description,
    required DateTime dateTime,
    List<String>? imagePaths,
  }) async {
    try {
      final eventModel = await _apiService.createEvent(
        name: name,
        description: description,
        dateTime: dateTime,
        imagePaths: imagePaths,
      );
      return eventModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to create event: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while creating event: $e');
    }
  }

  @override
  Future<Event> updateEvent({
    required String id,
    required String name,
    required String description,
    required DateTime dateTime,
    List<String>? imagePaths,
  }) async {
    try {
      final eventModel = await _apiService.updateEvent(
        id: int.parse(id),
        name: name,
        description: description,
        dateTime: dateTime,
        imagePaths: imagePaths,
      );
      return eventModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to update event: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while updating event: $e');
    }
  }

  @override
  Future<void> deleteEvent(String id) async {
    try {
      await _apiService.deleteEvent(int.parse(id));
    } on ApiException catch (e) {
      throw ApiException('Failed to delete event: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while deleting event: $e');
    }
  }
}