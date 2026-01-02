import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../models/book.dart';
import '../services/storage_service.dart';

class BookReadingScreen extends StatefulWidget {
  final Book book;

  const BookReadingScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookReadingScreen> createState() => _BookReadingScreenState();
}

class _BookReadingScreenState extends State<BookReadingScreen> {
  late Book _book;
  late PageController _pageController;
  bool _showControls = false;
  String _fontSize = 'medium';
  String _theme = 'light';
  String _bookContent = '';
  List<String> _pages = [];
  Timer? _readingTimer;
  DateTime? _startTime;
  int _totalReadingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
    _pageController = PageController(initialPage: _book.currentPage);
    _loadSettings();
    _loadBookContent();
    _startReadingTimer();
  }

  @override
  void dispose() {
    _stopReadingTimer();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final fontSize = await StorageService.loadFontSize();
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('appTheme') ?? 'light';
    setState(() {
      _fontSize = fontSize;
      _theme = theme;
    });
  }

  Future<void> _loadBookContent() async {
    try {
      final content = await rootBundle.loadString(_book.contentPath);
      setState(() {
        _bookContent = content;
        _pages = _paginateContent(content);
      });
    } catch (e) {
      // If book content file doesn't exist, use placeholder
      setState(() {
        _bookContent = _getPlaceholderContent();
        _pages = _paginateContent(_bookContent);
      });
    }
  }

  String _getPlaceholderContent() {
    return '''
${_book.title}
by ${_book.author}

This is a placeholder for the book content. You will need to add the actual book text content.

To add the real book content:
1. Convert your EPUB to plain text
2. Place the text file in assets/books/
3. Make sure the filename matches: ${_book.contentPath}

${_book.description}

[The rest of the book content will appear here once you add the text file]

This is just sample text to demonstrate the reading functionality. The app supports:
- Swipe gestures to turn pages
- Customizable font sizes
- Multiple theme options (Light, Dark, Sepia)
- Bookmarks
- Progress tracking
- Reading statistics

Enjoy reading with Boom!
''';
  }

  List<String> _paginateContent(String content) {
    // Simple pagination based on character count
    // In a real app, you'd do more sophisticated text measurement
    final wordsPerPage = _getWordsPerPage();
    final words = content.split(RegExp(r'\s+'));
    final pages = <String>[];

    for (int i = 0; i < words.length; i += wordsPerPage) {
      final end = (i + wordsPerPage < words.length) ? i + wordsPerPage : words.length;
      pages.add(words.sublist(i, end).join(' '));
    }

    return pages.isEmpty ? [''] : pages;
  }

  int _getWordsPerPage() {
    switch (_fontSize) {
      case 'small':
        return 350;
      case 'large':
        return 200;
      default:
        return 275;
    }
  }

  void _startReadingTimer() {
    _startTime = DateTime.now();
    _readingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _saveReadingProgress();
    });
  }

  void _stopReadingTimer() {
    _readingTimer?.cancel();
    _saveReadingProgress();
  }

  Future<void> _saveReadingProgress() async {
    if (_startTime != null) {
      final now = DateTime.now();
      final seconds = now.difference(_startTime!).inSeconds;
      _totalReadingSeconds += seconds;
      _startTime = now;

      if (_totalReadingSeconds >= 60) {
        final minutes = _totalReadingSeconds ~/ 60;
        await StorageService.addReadingTime(_book.id, minutes);
        _totalReadingSeconds = _totalReadingSeconds % 60;
      }
    }

    // Save current page and progress
    final currentPage = _pageController.page?.round() ?? 0;
    final progress = _pages.isEmpty ? 0.0 : currentPage / _pages.length;
    _book.currentPage = currentPage;
    _book.progress = progress.clamp(0.0, 1.0);
    await StorageService.updateBook(_book);

    // Check if completed
    if (progress >= 0.99 && !_book.isCompleted) {
      await StorageService.markBookCompleted(_book.id);
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Congratulations!'),
        content: Text(
          'You\'ve completed "${_book.title}"!\n\nKeep up the great reading habit!',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, _book);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: Stack(
          children: [
            // Page content
            SafeArea(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (page) {
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Text(
                        _pages[index],
                        style: TextStyle(
                          fontSize: _getFontSize(),
                          height: 1.8,
                          color: _getTextColor(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Top controls
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context, _book);
                            },
                          ),
                          Text(
                            _book.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _book.bookmarks.contains(_pageController.page?.round() ?? 0)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                onPressed: _toggleBookmark,
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings, color: Colors.white),
                                onPressed: _showSettingsDialog,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Bottom controls
            if (_showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Page ${(_pageController.page?.round() ?? 0) + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${_book.progressPercentage}%',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${_pages.length} pages',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SliderTheme(
                            data: SliderThemeData(
                              thumbColor: Colors.white,
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                            ),
                            child: Slider(
                              value: (_pageController.page ?? 0).toDouble(),
                              min: 0,
                              max: (_pages.length - 1).toDouble(),
                              onChanged: (value) {
                                _pageController.jumpToPage(value.round());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (_theme) {
      case 'dark':
        return const Color(0xFF1F2020);
      case 'sepia':
        return const Color(0xFFF9AF89);
      default:
        return const Color(0xFFEEEDEC);
    }
  }

  Color _getTextColor() {
    switch (_theme) {
      case 'dark':
        return const Color(0xFFEEEDEC);
      default:
        return const Color(0xFF1F2020);
    }
  }

  double _getFontSize() {
    switch (_fontSize) {
      case 'small':
        return 16.0;
      case 'large':
        return 22.0;
      default:
        return 18.0;
    }
  }

  void _toggleBookmark() async {
    final currentPage = _pageController.page?.round() ?? 0;
    if (_book.bookmarks.contains(currentPage)) {
      await StorageService.removeBookmark(_book.id, currentPage);
      setState(() {
        _book.bookmarks.remove(currentPage);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bookmark removed')),
      );
    } else {
      await StorageService.addBookmark(_book.id, currentPage);
      setState(() {
        _book.bookmarks.add(currentPage);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bookmark added')),
      );
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reading Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Font Size',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'small', label: Text('Small')),
                ButtonSegment(value: 'medium', label: Text('Medium')),
                ButtonSegment(value: 'large', label: Text('Large')),
              ],
              selected: {_fontSize},
              onSelectionChanged: (Set<String> selected) async {
                await StorageService.saveFontSize(selected.first);
                setState(() {
                  _fontSize = selected.first;
                  _pages = _paginateContent(_bookContent);
                  final currentProgress = _book.progress;
                  final newPage = (currentProgress * _pages.length).round();
                  _pageController.jumpToPage(newPage);
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Theme',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'light', label: Text('Light')),
                ButtonSegment(value: 'dark', label: Text('Dark')),
                ButtonSegment(value: 'sepia', label: Text('Sepia')),
              ],
              selected: {_theme},
              onSelectionChanged: (Set<String> selected) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('appTheme', selected.first);
                setState(() {
                  _theme = selected.first;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
