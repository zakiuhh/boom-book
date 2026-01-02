# 🚀 Quick Start Guide - Get Boom Running in 5 Minutes!

## ⚡ Fast Track to Running Your App

### 1️⃣ Open the Project (1 minute)

**Option A: Using Android Studio**
- Open Android Studio
- Click "Open an Existing Project"
- Navigate to `boom_flutter_app` folder
- Click "OK"

**Option B: Using VS Code**
- Open VS Code
- File → Open Folder
- Select `boom_flutter_app` folder

### 2️⃣ Install Dependencies (1 minute)

Open terminal in the project folder and run:
```bash
flutter pub get
```

### 3️⃣ Add Assets (2-3 minutes)

You need to add book covers and text content. Don't worry, we'll start simple!

**Quick Test Version (Use Placeholders First):**

For now, just create empty placeholder files to test the app structure:

```bash
# Book covers - use any 10 images you have (rename them)
# Place in: assets/images/covers/

# Example: If you have a photo called "photo.jpg", 
# copy it 10 times and rename to each book cover name

# Book text - the app will show placeholder text if files are missing
# You can add real books later!
```

**The 10 filenames you need:**

**Covers** (in `assets/images/covers/`):
1. around_the_world.jpg
2. monte_cristo.jpg
3. jekyll_hyde.jpg
4. dorian_gray.jpg
5. call_of_wild.jpg
6. treasure_island.jpg
7. sherlock_holmes.jpg
8. dracula.jpg
9. pride_prejudice.jpg
10. great_gatsby.jpg

**Book Text** (in `assets/books/`) - *Optional for testing*:
1. around_the_world.txt
2. monte_cristo.txt
3. jekyll_hyde.txt
4. dorian_gray.txt
5. call_of_wild.txt
6. treasure_island.txt
7. sherlock_holmes.txt
8. dracula.txt
9. pride_prejudice.txt
10. great_gatsby.txt

💡 **Pro Tip:** For quick testing, use the same image 10 times with different names!

### 4️⃣ Run the App! (30 seconds)

```bash
flutter run
```

Or press **F5** in VS Code / **Shift+F10** in Android Studio

---

## 🎯 What You'll See

1. **Onboarding Screens** - 3 welcome screens (you can skip)
2. **Username Prompt** - Enter your name
3. **Home Screen** - Your reading dashboard
4. **Library** - Grid of all 10 books
5. **Statistics** - Your reading stats (will be empty at first)
6. **About** - App information
7. **Settings** - Customize themes, fonts, etc.

---

## 📚 Adding Real Book Content Later

When you're ready to add actual books:

### Get Free Books:
1. Visit **Project Gutenberg**: https://www.gutenberg.org/
2. Search for any of the 10 book titles
3. Download as "Plain Text UTF-8"
4. Save with correct filename in `assets/books/`

### Get Book Covers:
1. Search Google Images for "[book title] cover"
2. Download high-quality images
3. Rename to match required filename
4. Place in `assets/images/covers/`

See **ASSETS_GUIDE.md** for detailed instructions!

---

## 🔧 Common Issues & Quick Fixes

### "Unable to load asset" error
```bash
flutter clean
flutter pub get
flutter run
```

### App won't start
- Check you have at least placeholder files in assets folders
- Make sure you ran `flutter pub get`
- Try restarting your IDE

### Images not showing
- Check filenames match EXACTLY (case-sensitive)
- Files must be in correct folders
- Supported formats: JPG, PNG

---

## ✅ Testing Checklist

Before adding real content, test these features:

- [ ] App opens without crashing
- [ ] Onboarding screens work
- [ ] Can enter username
- [ ] Home screen loads
- [ ] Can navigate via drawer menu
- [ ] Can tap on a book
- [ ] Book detail page opens
- [ ] Can "Start Reading" a book
- [ ] Reading screen opens (shows placeholder if no content)
- [ ] Can swipe between pages
- [ ] Can bookmark pages
- [ ] Settings work (change theme, font size)

---

## 📱 Running on Different Devices

### Android Emulator:
1. Open Android Studio
2. Tools → AVD Manager
3. Create/Start a virtual device
4. Run `flutter run`

### Physical Android Device:
1. Enable Developer Options on phone
2. Enable USB Debugging
3. Connect via USB
4. Run `flutter run`

### iOS Simulator (Mac only):
1. Open Xcode
2. Open Simulator
3. Run `flutter run`

---

## 🎨 Customization Quick Tips

### Change App Colors:
Edit `lib/utils/app_colors.dart`

### Change App Name:
Edit `pubspec.yaml` (name field)

### Add More Books:
Edit `lib/data/books_data.dart`

### Modify Themes:
Edit `lib/main.dart` → `AppThemes` class

---

## 🆘 Need Help?

1. Check error messages in terminal
2. Read **README.md** for detailed docs
3. Read **ASSETS_GUIDE.md** for asset help
4. Run `flutter doctor` to check setup
5. Clean and rebuild: `flutter clean && flutter pub get`

---

## 🎉 You're Ready!

Your Boom app should now be running! 

**Next Steps:**
1. Play around with the app to understand features
2. Start adding real book covers (see ASSETS_GUIDE.md)
3. Download books from Project Gutenberg
4. Customize colors and themes to your liking

---

**Time Estimate:**
- Quick test with placeholders: **5 minutes**
- Full setup with all books: **30-60 minutes**

Enjoy your reading app! 📚✨
