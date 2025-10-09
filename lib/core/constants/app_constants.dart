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
  static const bool useMockData = true; // API muammolari tufayli mock data ishlatamiz
  static const String mockBooksPath = 'assets/mock/books.json';
  static const String mockUsersPath = 'assets/mock/users.json';
  static const String mockCategoriesPath = 'assets/mock/categories.json';
  static const String mockRegionsPath = 'assets/mock/regions.json';
}

class ApiEndpoints {
  // Authentication - Users Controller
  static const String login = '/api/Users/LogIn';
  static const String register = '/api/Users/Create';
  static const String getAllUsers = '/api/Users/GetAllUsers';
  static const String getUserById = '/api/Users/GetByIdUser';
  static const String getCurrentUser = '/api/Users/GetCurrentUser';
  static const String updateUser = '/api/Users/Update';
  static const String deleteUser = '/api/Users/Delete';
  static const String getUserCount = '/api/Users/GetCountUsers';
  static const String getUsersByRegion = '/api/Users/CountUsersByRegion/{Id}';
  static const String getNonUniverUsers = '/api/Users/GetNonUniverUsers/get-other-users';
  static const String getUniverUsers = '/api/Users/GetUniverUsers/get-univer-users';
  
  // Books Controller
  static const String books = '/api/Books/GetAll';
  static const String bookById = '/api/Books/Get/{id}';
  static const String createBook = '/api/Books/Create';
  static const String updateBook = '/api/Books/Update/{id}';
  static const String deleteBook = '/api/Books/Delete/{id}';
  static const String getBookCount = '/api/Books/GetCountBooks';
  static const String getBookCountTotal = '/api/Books/BookCount';
  
  // Authors Controller
  static const String authors = '/api/Author/GetAll';
  static const String authorById = '/api/Author/Get/{Id}';
  static const String createAuthor = '/api/Author/Create';
  static const String updateAuthor = '/api/Author/Update/{Id}';
  static const String deleteAuthor = '/api/Author/Delete/{Id}';
  static const String getAuthorBooks = '/api/Author/Get-Author-Books/{Id}';
  static const String getAuthorCount = '/api/Author/Count';
  
  // Ratings Controller
  static const String ratings = '/api/Ratings/GetAllRatings';
  static const String ratingsById = '/api/Ratings/GetAllRatingById';
  static const String createRating = '/api/Ratings/AddRate';
  static const String updateRating = '/api/Ratings/UpdateRate';
  static const String deleteRating = '/api/Ratings/DeleteRate';
  
  // Saved Books Controller
  static const String savedBooks = '/api/SavedBooks/user/{userId}';
  static const String createSavedBook = '/api/SavedBooks';
  static const String deleteSavedBook = '/api/SavedBooks/{id}';
  
  // Borrowings Controller
  static const String borrowings = '/api/Borrowings/AllBOrrowings/borrowings';
  static const String createBorrowing = '/api/Borrowings/BorrowBook/borrow';
  static const String returnBorrowing = '/api/Borrowings/ReturnBook/return';
  static const String myBorrowings = '/api/Borrowings/MyBorrowingsForUserId/my';
  static const String activeBorrowings = '/api/Borrowings/GetActiveBorrowings';
  static const String borrowingRecords = '/api/Borrowings/BorrowingRecords';
  static const String activeBorrowedCount = '/api/Borrowings/GetActiveBorrowedBooksCount/count-active-borrowed-books';
  static const String returnedBooksCount = '/api/Borrowings/GetReturnedBooksCount/count-returned-books';
  static const String last7DaysStats = '/api/Borrowings/GetLast7DaysBorrowStats';
  static const String borrowSummary = '/api/Borrowings/GetBorrowSummary';
  
  // Categories & Genres
  static const String genres = '/api/Genres/GetAllGenre';
  static const String createGenre = '/api/Genres/CreateGenre';
  static const String genreById = '/api/Genres/GetByIdGenre';
  static const String updateGenre = '/api/Genres/Update';
  static const String deleteGenre = '/api/Genres/Delete';
  static const String genreCount = '/api/Genres/GetCountGenre';
  
  static const String generalCategories = '/api/GeneralCategories';
  static const String createGeneralCategory = '/api/GeneralCategories';
  static const String updateGeneralCategory = '/api/GeneralCategories/{id}';
  static const String deleteGeneralCategory = '/api/GeneralCategories/{id}';
  
  static const String bookCategories = '/api/BookCategories';
  static const String createBookCategory = '/api/BookCategories';
  static const String updateBookCategory = '/api/BookCategories/{id}';
  static const String deleteBookCategory = '/api/BookCategories/{id}';
  
  static const String bookMiddleCategories = '/api/BookMiddleCategories';
  static const String createBookMiddleCategory = '/api/BookMiddleCategories';
  static const String updateBookMiddleCategory = '/api/BookMiddleCategories/{id}';
  static const String deleteBookMiddleCategory = '/api/BookMiddleCategories/{id}';
  
  // General Groups
  static const String generalGroups = '/api/GeneralGroups';
  static const String createGeneralGroup = '/api/GeneralGroups';
  static const String updateGeneralGroup = '/api/GeneralGroups/{id}';
  static const String deleteGeneralGroup = '/api/GeneralGroups/{id}';
  
  // Events Controller
  static const String events = '/api/Events/get-all';
  static const String eventById = '/api/Events/get-by-id/{id}';
  static const String createEvent = '/api/Events/create';
  static const String updateEvent = '/api/Events/update/{id}';
  static const String deleteEvent = '/api/Events/delete/{id}';
  
  // Regions Controller
  static const String regions = '/api/Regions';
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
