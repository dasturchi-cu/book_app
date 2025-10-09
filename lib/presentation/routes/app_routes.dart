import 'package:get/get.dart';
import 'package:book_app/presentation/pages/home_page.dart';
import 'package:book_app/presentation/pages/book_details_page.dart';
import 'package:book_app/presentation/pages/book_reader_page.dart';
import 'package:book_app/presentation/pages/search_page.dart';
import 'package:book_app/presentation/pages/favorites_page.dart';
import 'package:book_app/presentation/pages/profile_page.dart';
import 'package:book_app/presentation/pages/login_page.dart';
import 'package:book_app/presentation/pages/api_test_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
  static const String bookDetails = '/book-details';
  static const String bookReader = '/book-reader';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String videoLessons = '/video-lessons';
  static const String requirements = '/requirements';
  static const String textbooks = '/textbooks';
  static const String apiTest = '/api-test';

  static final List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(
      name: bookDetails,
      page: () => BookDetailsPage(book: Get.arguments),
    ),
    GetPage(
      name: bookReader,
      page: () => BookReaderPage(book: Get.arguments),
    ),
    GetPage(name: search, page: () => const SearchPage()),
    GetPage(name: favorites, page: () => const FavoritesPage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: apiTest, page: () => const ApiTestPage()),
  ];
}
