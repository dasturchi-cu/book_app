import 'package:book_app/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
  Future<List<Event>> getUpcomingEvents();
  Future<List<Event>> getPastEvents();
}
