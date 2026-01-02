class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final List<String> tags;
  final String contentPath; // Path to book content
  final int estimatedPages;
  
  double progress; // 0.0 to 1.0
  int currentPage;
  List<int> bookmarks;
  int totalReadingMinutes;
  bool isCompleted;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.tags,
    required this.contentPath,
    required this.estimatedPages,
    this.progress = 0.0,
    this.currentPage = 0,
    this.bookmarks = const [],
    this.totalReadingMinutes = 0,
    this.isCompleted = false,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImage': coverImage,
      'tags': tags,
      'contentPath': contentPath,
      'estimatedPages': estimatedPages,
      'progress': progress,
      'currentPage': currentPage,
      'bookmarks': bookmarks,
      'totalReadingMinutes': totalReadingMinutes,
      'isCompleted': isCompleted,
    };
  }

  // Create from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverImage: json['coverImage'],
      tags: List<String>.from(json['tags']),
      contentPath: json['contentPath'],
      estimatedPages: json['estimatedPages'],
      progress: json['progress'] ?? 0.0,
      currentPage: json['currentPage'] ?? 0,
      bookmarks: List<int>.from(json['bookmarks'] ?? []),
      totalReadingMinutes: json['totalReadingMinutes'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Create a copy with updated values
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImage,
    List<String>? tags,
    String? contentPath,
    int? estimatedPages,
    double? progress,
    int? currentPage,
    List<int>? bookmarks,
    int? totalReadingMinutes,
    bool? isCompleted,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      tags: tags ?? this.tags,
      contentPath: contentPath ?? this.contentPath,
      estimatedPages: estimatedPages ?? this.estimatedPages,
      progress: progress ?? this.progress,
      currentPage: currentPage ?? this.currentPage,
      bookmarks: bookmarks ?? this.bookmarks,
      totalReadingMinutes: totalReadingMinutes ?? this.totalReadingMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Get progress percentage
  int get progressPercentage => (progress * 100).round();

  // Check if book is started
  bool get isStarted => progress > 0.0;

  // Check if book is in progress
  bool get isInProgress => isStarted && !isCompleted;
}
