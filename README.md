# 📚 Boom - Book Reading App

A beautiful Flutter book reading application with 10 pre-loaded classic literature books. Built for book lovers who want a clean, customizable reading experience.

## ✨ Features

- 📖 **10 Pre-loaded Classic Books** - Timeless literature ready to read
- 🎨 **Three Beautiful Themes** - Light, Dark, and Sepia modes
- 🔤 **Adjustable Font Sizes** - Small, Medium, Large for comfortable reading
- 🔖 **Bookmarks** - Save your favorite passages
- 📊 **Reading Statistics** - Track your reading time and progress
- 📈 **Progress Tracking** - Visual progress bars for each book
- 🎯 **Clean UI** - Minimalist, distraction-free reading experience
- 💾 **Local Storage** - All data saved securely on your device

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android or iOS device/emulator

### Installation

1. **Clone or download this project**

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Add book covers** (REQUIRED)

   Place your book cover images in `assets/images/covers/` with these exact names:
   - `around_the_world.jpg`
   - `monte_cristo.jpg`
   - `jekyll_hyde.jpg`
   - `dorian_gray.jpg`
   - `call_of_wild.jpg`
   - `treasure_island.jpg`
   - `sherlock_holmes.jpg`
   - `dracula.jpg`
   - `pride_prejudice.jpg`
   - `great_gatsby.jpg`

   📌 **Your covers should be:**
   - Format: JPG or PNG
   - Recommended size: 400x600px or similar book cover ratio
   - Named EXACTLY as shown above

4. **Add book content** (REQUIRED)

   Convert your EPUB books to plain text and place them in `assets/books/` with these exact names:
   - `around_the_world.txt`
   - `monte_cristo.txt`
   - `jekyll_hyde.txt`
   - `dorian_gray.txt`
   - `call_of_wild.txt`
   - `treasure_island.txt`
   - `sherlock_holmes.txt`
   - `dracula.txt`
   - `pride_prejudice.txt`
   - `great_gatsby.txt`

   **How to convert EPUB to TXT:**
   - Use Calibre (free software): <https://calibre-ebook.com/>
   - Open EPUB in Calibre
   - Click "Convert books"
   - Select output format as "TXT"
   - Save with the filename above

   **Where to get the books:**
   - Project Gutenberg: <https://www.gutenberg.org/>
   - Standard Ebooks: <https://standardebooks.org/>
   - All books listed are public domain classics

5. **Add app logo** (OPTIONAL)

   Place your logo in `assets/images/logo/`:
   - `logo.png` (200x200px, transparent background)

6. **Run the app**

   ```bash
   flutter run
   ```

## 📂 Project Structure

```
boom_flutter_app/
├── lib/
│   ├── main.dart                     # App entry point
│   ├── models/
│   │   ├── book.dart                 # Book data model
│   │   └── reading_statistics.dart   # Statistics model
│   ├── screens/
│   │   ├── onboarding_screen.dart    # First-time user intro
│   │   ├── main_screen.dart          # Main navigation
│   │   ├── home_screen.dart          # Home with continue reading
│   │   ├── library_screen.dart       # All books grid
│   │   ├── statistics_screen.dart    # Reading stats & graphs
│   │   ├── about_screen.dart         # App info
│   │   ├── settings_screen.dart      # User preferences
│   │   ├── book_detail_screen.dart   # Book details
│   │   └── book_reading_screen.dart  # Reading interface
│   ├── widgets/
│   │   └── book_card.dart            # Reusable book card
│   ├── services/
│   │   └── storage_service.dart      # Data persistence
│   ├── utils/
│   │   └── app_colors.dart           # Color constants
│   └── data/
│       └── books_data.dart           # Initial books data
├── assets/
│   ├── images/
│   │   ├── covers/                   # Book cover images
│   │   └── logo/                     # App logo
│   └── books/                        # Book text content
├── pubspec.yaml                      # Dependencies
└── README.md                         # This file
```

## 🎨 Color Scheme

The app uses your specified color scheme:

**Light Theme:**

- Background: #EEEDEC (cream)
- Secondary: #CBC2A3 (tan)
- Text: #1F2020 (dark)
- Accent: #D12029 (red)

**Dark Theme:**

- Background: #1F2020 (dark)
- Secondary: #424930 (dark olive)
- Text: #EEEDEC (cream)
- Accent: #D12029 (red)

**Sepia Theme:**

- Background: #F9AF89 (warm peach)
- Secondary: #CBC2A3 (tan)
- Text: #1F2020 (dark)
- Accent: #77393C (burgundy)

## 📚 The 10 Books Included

1. **Around the World in Eighty Days** - Jules Verne
2. **The Count of Monte Cristo** - Alexandre Dumas
3. **The Strange Case of Dr. Jekyll and Mr. Hyde** - Robert Louis Stevenson
4. **The Picture of Dorian Gray** - Oscar Wilde
5. **The Call of the Wild** - Jack London
6. **Treasure Island** - Robert Louis Stevenson
7. **The Adventures of Sherlock Holmes** - Arthur Conan Doyle
8. **Dracula** - Bram Stoker
9. **Pride and Prejudice** - Jane Austen
10. **The Great Gatsby** - F. Scott Fitzgerald

## 🔧 Customization

### Adding More Books

To add more books, edit `lib/data/books_data.dart`:

```dart
Book(
  id: '11',
  title: 'Your Book Title',
  author: 'Author Name',
  description: 'Book description...',
  coverImage: 'assets/images/covers/your_book.jpg',
  tags: ['Tag1', 'Tag2', 'Tag3'],
  contentPath: 'assets/books/your_book.txt',
  estimatedPages: 300,
),
```

### Changing Colors

Edit `lib/utils/app_colors.dart` to customize the color scheme.

### Modifying Themes

Edit the theme definitions in `lib/main.dart` in the `AppThemes` class.

## 📱 Running on Zapp

If you're using Zapp:

1. Create a new Flutter project in Zapp
2. Copy all files from `lib/` folder into your Zapp project
3. Update `pubspec.yaml` with the dependencies
4. Add assets as instructed above
5. Run the app!

## 🐛 Troubleshooting

### App crashes on startup

- Make sure you've added all book covers and content files
- Check that filenames match exactly (case-sensitive)
- Run `flutter clean` and `flutter pub get`

### Books show placeholder text

- You haven't added the book content files yet
- Files are in the wrong location or wrong names
- Check `assets/books/` folder

### Images not showing

- Book covers are missing or incorrectly named
- Check `assets/images/covers/` folder
- Make sure images are in JPG/PNG format

### Reading time not tracking

- This is normal in debug mode if app is paused
- Works correctly in release builds

## 📄 License

This project structure is free to use. However, please respect the copyright of the book content you add. All books mentioned are public domain classics.

## 👨‍💻 Developer

**Zaki Ul Hassan**

- GitHub: @zakiuhh
- Email: <zakiulhassan105@gmail.com>

## 🙏 Acknowledgments

- Book content from Project Gutenberg
- Flutter framework and community
- All the authors of these timeless classics

---

**Made with ❤️ for book lovers**

Happy Reading! 📚✨
