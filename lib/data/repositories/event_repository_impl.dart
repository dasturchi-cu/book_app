import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/event.dart';
import 'package:book_app/domain/repositories/event_repository.dart';
import 'package:book_app/data/models/event_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class EventRepositoryImpl implements EventRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<Event>> getAllEvents() async {
    try {
      final response = await _dio.get(ApiEndpoints.events);
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => EventModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get events: $e');
    }
  }

  @override
  Future<Event> getEventById(String id) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.eventById.replaceAll('{id}', id),
      );
      
      return EventModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to get event: $e');
    }
  }

  @override
  Future<List<Event>> getUpcomingEvents() async {
    try {
      final events = await getAllEvents();
      final now = DateTime.now();
      
      return events.where((event) => event.startDate.isAfter(now)).toList();
    } catch (e) {
      throw Exception('Failed to get upcoming events: $e');
    }
  }

  @override
  Future<List<Event>> getPastEvents() async {
    try {
      final events = await getAllEvents();
      final now = DateTime.now();
      
      return events.where((event) => event.endDate.isBefore(now)).toList();
    } catch (e) {
      throw Exception('Failed to get past events: $e');
    }
  }
}
