import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/book.dart';
import 'package:book_app/domain/repositories/book_repository.dart';
import 'package:book_app/domain/repositories/saved_book_repository.dart';
import 'package:book_app/domain/repositories/borrowing_repository.dart';
import 'package:book_app/domain/repositories/rating_repository.dart';

class BookController extends GetxController {
  final BookRepository _bookRepository = Get.find<BookRepository>();
  final SavedBookRepository _savedBookRepository = Get.find<SavedBookRepository>();
  final BorrowingRepository _borrowingRepository = Get.find<BorrowingRepository>();
  final RatingRepository _ratingRepository = Get.find<RatingRepository>();

  // Reactive variables
  final RxList<Book> books = <Book>[].obs;
  final RxList<Book> filteredBooks = <Book>[].obs;
  final RxList<Book> favoriteBooks = <Book>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = ''.obs;
  final RxString selectedAuthor = ''.obs;
  final RxString selectedGenre = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Load all books from repository
  Future<void> loadBooks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final booksList = await _bookRepository.getAllBooks();
      books.value = booksList;
      filteredBooks.value = booksList;
      
      // Extract categories from books
      final Set<String> categorySet = {};
      for (final book in booksList) {
        categorySet.addAll(book.categories);
      }
      categories.value = categorySet.toList()..sort();
      
    } catch (e) {
      errorMessage.value = 'Failed to load books: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Search books by query
  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      filteredBooks.value = books;
      searchQuery.value = '';
      return;
    }

    try {
      isSearching.value = true;
      searchQuery.value = query;

      final searchResults = await _bookRepository.searchBooks(query);
      filteredBooks.value = searchResults;
    } catch (e) {
      errorMessage.value = 'Search failed: $e';
    } finally {
      isSearching.value = false;
    }
  }

  /// Filter books by category
  Future<void> filterByCategory(String category) async {
    if (category.isEmpty) {
      filteredBooks.value = books;
      selectedCategory.value = '';
      return;
    }

    try {
      selectedCategory.value = category;
      final categoryBooks = await _bookRepository.getBooksByCategory(category);
      filteredBooks.value = categoryBooks;
    } catch (e) {
      errorMessage.value = 'Filter failed: $e';
    }
  }

  /// Filter books by author
  Future<void> filterByAuthor(String authorId) async {
    if (authorId.isEmpty) {
      filteredBooks.value = books;
      selectedAuthor.value = '';
      return;
    }

    try {
      selectedAuthor.value = authorId;
      final authorBooks = await _bookRepository.getBooksByAuthor(authorId);
      filteredBooks.value = authorBooks;
    } catch (e) {
      errorMessage.value = 'Filter failed: $e';
    }
  }

  /// Filter books by genre
  Future<void> filterByGenre(String genreId) async {
    if (genreId.isEmpty) {
      filteredBooks.value = books;
      selectedGenre.value = '';
      return;
    }

    try {
      selectedGenre.value = genreId;
      final genreBooks = await _bookRepository.getBooksByGenre(genreId);
      filteredBooks.value = genreBooks;
    } catch (e) {
      errorMessage.value = 'Filter failed: $e';
    }
  }

  /// Clear all filters
  void clearFilters() {
    filteredBooks.value = books;
    searchQuery.value = '';
    selectedCategory.value = '';
    selectedAuthor.value = '';
    selectedGenre.value = '';
  }

  /// Save book to favorites
  Future<void> saveBook(String bookId) async {
    try {
      await _savedBookRepository.saveBook(bookId);
      await loadFavoriteBooks();
    } catch (e) {
      errorMessage.value = 'Failed to save book: $e';
    }
  }

  /// Remove book from favorites
  Future<void> removeSavedBook(String savedBookId) async {
    try {
      await _savedBookRepository.removeSavedBook(savedBookId);
      await loadFavoriteBooks();
    } catch (e) {
      errorMessage.value = 'Failed to remove saved book: $e';
    }
  }

  /// Load favorite books
  Future<void> loadFavoriteBooks() async {
    try {
      final savedBooks = await _savedBookRepository.getAllSavedBooks();
      // Convert saved books to actual book objects
      final favoriteBookIds = savedBooks.map((sb) => sb.bookId).toList();
      final favoriteBooksList = books.where((book) => favoriteBookIds.contains(book.id)).toList();
      favoriteBooks.value = favoriteBooksList;
    } catch (e) {
      errorMessage.value = 'Failed to load favorites: $e';
    }
  }

  /// Borrow a book
  Future<void> borrowBook(String bookId) async {
    try {
      await _borrowingRepository.borrowBook(bookId);
      // Refresh books to update availability
      await loadBooks();
    } catch (e) {
      errorMessage.value = 'Failed to borrow book: $e';
    }
  }

  /// Return a borrowed book
  Future<void> returnBook(String borrowingId) async {
    try {
      await _borrowingRepository.returnBook(borrowingId);
      // Refresh books to update availability
      await loadBooks();
    } catch (e) {
      errorMessage.value = 'Failed to return book: $e';
    }
  }

  /// Rate a book
  Future<void> rateBook(String bookId, double rating, {String? review}) async {
    try {
      await _ratingRepository.createRating(bookId, rating, review);
    } catch (e) {
      errorMessage.value = 'Failed to rate book: $e';
    }
  }

  /// Get book by ID
  Future<Book?> getBookById(String id) async {
    try {
      return await _bookRepository.getBookById(id);
    } catch (e) {
      errorMessage.value = 'Failed to load book: $e';
      return null;
    }
  }

  /// Check if a book is saved
  Future<bool> isBookSaved(String bookId) async {
    try {
      return await _savedBookRepository.isBookSaved(bookId);
    } catch (e) {
      return false;
    }
  }

  /// Check if a book is borrowed
  Future<bool> isBookBorrowed(String bookId) async {
    try {
      return await _borrowingRepository.isBookBorrowed(bookId);
    } catch (e) {
      return false;
    }
  }

  /// Get average rating for a book
  Future<double> getBookRating(String bookId) async {
    try {
      return await _ratingRepository.getAverageRating(bookId);
    } catch (e) {
      return 0.0;
    }
  }

  /// Toggle favorite status for a book
  Future<void> toggleFavorite(String bookId) async {
    try {
      final isSaved = await isBookSaved(bookId);
      if (isSaved) {
        // Find and remove the saved book
        final savedBooks = await _savedBookRepository.getAllSavedBooks();
        final savedBook = savedBooks.firstWhere((sb) => sb.bookId == bookId);
        await removeSavedBook(savedBook.id);
      } else {
        await saveBook(bookId);
      }
    } catch (e) {
      errorMessage.value = 'Failed to toggle favorite: $e';
    }
  }

  /// Get books count
  int get booksCount => books.length;

  /// Get filtered books count
  int get filteredBooksCount => filteredBooks.length;

  /// Get favorite books count
  int get favoriteBooksCount => favoriteBooks.length;
}
