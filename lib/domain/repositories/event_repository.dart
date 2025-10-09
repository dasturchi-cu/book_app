import 'package:book_app/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents();
  Future<Event> getEventById(String id);
  Future<Event> createEvent({
    required String name,
    required String description,
    required DateTime dateTime,
    List<String>? imagePaths,
  });
  Future<Event> updateEvent({
    required String id,
    required String name,
    required String description,
    required DateTime dateTime,
    List<String>? imagePaths,
  });
  Future<void> deleteEvent(String id);
}