import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import '../models/reading_statistics.dart';
import '../data/books_data.dart';

class StorageService {
  static const String _booksKey = 'books_data';
  static const String _statsKey = 'reading_stats';
  static const String _usernameKey = 'username';
  static const String _fontSizeKey = 'font_size';
  static const String _themeKey = 'app_theme';

  // Initialize books if not exists
  static Future<List<Book>> initializeBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final booksJson = prefs.getString(_booksKey);

    if (booksJson == null) {
      // First time - save initial books
      final initialBooks = BooksData.getInitialBooks();
      await saveBooks(initialBooks);
      return initialBooks;
    }

    // Load existing books
    return loadBooks();
  }

  // Save books
  static Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    final booksJson = jsonEncode(books.map((book) => book.toJson()).toList());
    await prefs.setString(_booksKey, booksJson);
  }

  // Load books
  static Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final booksJson = prefs.getString(_booksKey);

    if (booksJson == null) {
      return BooksData.getInitialBooks();
    }

    final List<dynamic> decoded = jsonDecode(booksJson);
    return decoded.map((json) => Book.fromJson(json)).toList();
  }

  // Update single book
  static Future<void> updateBook(Book book) async {
    final books = await loadBooks();
    final index = books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      books[index] = book;
      await saveBooks(books);
    }
  }

  // Save username
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Load username
  static Future<String?> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Save reading statistics
  static Future<void> saveStatistics(ReadingStatistics stats) async {
    final prefs = await SharedPreferences.getInstance();
    final statsJson = jsonEncode(stats.toJson());
    await prefs.setString(_statsKey, statsJson);
  }

  // Load reading statistics
  static Future<ReadingStatistics> loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final statsJson = prefs.getString(_statsKey);

    if (statsJson == null) {
      return ReadingStatistics.empty();
    }

    return ReadingStatistics.fromJson(jsonDecode(statsJson));
  }

  // Update reading time
  static Future<void> addReadingTime(String bookId, int minutes) async {
    final books = await loadBooks();
    final stats = await loadStatistics();

    // Update book reading time
    final bookIndex = books.indexWhere((b) => b.id == bookId);
    if (bookIndex != -1) {
      books[bookIndex].totalReadingMinutes += minutes;
      await saveBooks(books);
    }

    // Update daily statistics
    final today = _formatDate(DateTime.now());
    final updatedDaily = Map<String, int>.from(stats.dailyReadingMinutes);
    updatedDaily[today] = (updatedDaily[today] ?? 0) + minutes;

    final updatedStats = ReadingStatistics(
      totalBooksRead: stats.totalBooksRead,
      totalReadingMinutes: stats.totalReadingMinutes + minutes,
      dailyReadingMinutes: updatedDaily,
      lastReadDate: DateTime.now(),
    );

    await saveStatistics(updatedStats);
  }

  // Mark book as completed
  static Future<void> markBookCompleted(String bookId) async {
    final books = await loadBooks();
    final stats = await loadStatistics();

    final bookIndex = books.indexWhere((b) => b.id == bookId);
    if (bookIndex != -1 && !books[bookIndex].isCompleted) {
      books[bookIndex].isCompleted = true;
      books[bookIndex].progress = 1.0;
      await saveBooks(books);

      // Update total books read
      final updatedStats = ReadingStatistics(
        totalBooksRead: stats.totalBooksRead + 1,
        totalReadingMinutes: stats.totalReadingMinutes,
        dailyReadingMinutes: stats.dailyReadingMinutes,
        lastReadDate: DateTime.now(),
      );
      await saveStatistics(updatedStats);
    }
  }

  // Save font size
  static Future<void> saveFontSize(String size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontSizeKey, size);
  }

  // Load font size
  static Future<String> loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fontSizeKey) ?? 'medium';
  }

  // Reset all progress
  static Future<void> resetAllProgress() async {
    final books = BooksData.getInitialBooks();
    await saveBooks(books);
    await saveStatistics(ReadingStatistics.empty());
  }

  // Reset specific book
  static Future<void> resetBookProgress(String bookId) async {
    final books = await loadBooks();
    final bookIndex = books.indexWhere((b) => b.id == bookId);
    if (bookIndex != -1) {
      books[bookIndex] = books[bookIndex].copyWith(
        progress: 0.0,
        currentPage: 0,
        isCompleted: false,
        totalReadingMinutes: 0,
      );
      await saveBooks(books);
    }
  }

  // Clear all bookmarks
  static Future<void> clearAllBookmarks() async {
    final books = await loadBooks();
    for (var book in books) {
      book.bookmarks = [];
    }
    await saveBooks(books);
  }

  // Add bookmark
  static Future<void> addBookmark(String bookId, int page) async {
    final books = await loadBooks();
    final bookIndex = books.indexWhere((b) => b.id == bookId);
    if (bookIndex != -1) {
      if (!books[bookIndex].bookmarks.contains(page)) {
        books[bookIndex].bookmarks.add(page);
        await saveBooks(books);
      }
    }
  }

  // Remove bookmark
  static Future<void> removeBookmark(String bookId, int page) async {
    final books = await loadBooks();
    final bookIndex = books.indexWhere((b) => b.id == bookId);
    if (bookIndex != -1) {
      books[bookIndex].bookmarks.remove(page);
      await saveBooks(books);
    }
  }

  static String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
