class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://194.93.25.19:5050';
  static const String swaggerUrl =
      'http://194.93.25.19:5050/swagger/index.html';
  static const Duration apiTimeout = Duration(seconds: 30);

  // App Configuration
  static const String appName = 'IIV MOI Books';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int booksPerPage = 20;
  static const int maxRetryAttempts = 3;

  // Reading Settings
  static const double minFontSize = 12.0;
  static const double maxFontSize = 24.0;
  static const double defaultFontSize = 16.0;

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String readingSettingsKey = 'reading_settings';
  static const String favoriteBooksKey = 'favorite_books';

  // Mock Data
  static const bool useMockData = true;
  static const String mockBooksPath = 'assets/mock/books.json';
  static const String mockUsersPath = 'assets/mock/users.json';
  static const String mockCategoriesPath = 'assets/mock/categories.json';
}

class ApiEndpoints {
  // Authentication - Swagger API dan tekshirilgan endpointlar
  static const String login = '/api/Users/LogIn';  // Swagger da Users controller da
  static const String register = '/api/Users/Create';  // Swagger da Users controller da
  
  // Books - Swagger da mavjud
  static const String books = '/api/Books/GetAll';
  static const String bookById = '/api/Books/Get/{id}';
  static const String createBook = '/api/Books/Create';
  static const String updateBook = '/api/Books/Update/{id}';
  static const String deleteBook = '/api/Books/Delete/{id}';
  
  // Ratings - Swagger da mavjud
  static const String ratings = '/api/Ratings/GetAllRatings';
  static const String createRating = '/api/Ratings/AddRate';
  static const String updateRating = '/api/Ratings/UpdateRate';
  static const String deleteRating = '/api/Ratings/DeleteRate';
  
  // Saved Books - Swagger API dan to'g'ri endpointlar
  static const String savedBooks = '/api/SavedBooks/user/{userId}';  // GET - user saved books
  static const String createSavedBook = '/api/SavedBooks';  // POST - create saved book
  static const String deleteSavedBook = '/api/SavedBooks/{id}';  // DELETE - remove saved book
  
  // Borrowings - Swagger da mavjud
  static const String borrowings = '/api/Borrowings/AllBorrowings/borrowings';
  static const String createBorrowing = '/api/Borrowings/BorrowBook/borrow';
  static const String returnBorrowing = '/api/Borrowings/ReturnBook/return';
  
  // Categories & Authors - Swagger da mavjud
  static const String authors = '/api/Author/GetAll';
  static const String genres = '/api/Genres/GetAllGenre';
  static const String generalCategories = '/api/GeneralCategories';
  static const String bookCategories = '/api/BookCategories/GetAll';
  static const String bookMiddleCategories = '/api/BookMiddleCategories/GetAll';
  
  // Events - Swagger da mavjud
  static const String events = '/api/Events/get-all';
  static const String eventById = '/api/Events/get-by-id/{id}';
  static const String createEvent = '/api/Events/create';
}

class AppStrings {
  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String filter = 'Filter';

  // Books
  static const String books = 'Books';
  static const String bookDetails = 'Book Details';
  static const String readBook = 'Read Book';
  static const String addToFavorites = 'Add to Favorites';
  static const String removeFromFavorites = 'Remove from Favorites';
  static const String rateBook = 'Rate Book';
  static const String writeReview = 'Write Review';

  // Navigation
  static const String home = 'Home';
  static const String searchPage = 'Search';
  static const String favorites = 'Favorites';
  static const String profile = 'Profile';

  // Authentication
  static const String login = 'Login';
  static const String register = 'Register';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';

  // Error Messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String noBooksFound = 'No books found.';
  static const String loginFailed =
      'Login failed. Please check your credentials.';
}
