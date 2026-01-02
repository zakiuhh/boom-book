# 📦 Assets Guide - How to Add Your Book Covers and Content

## 🖼️ Book Covers

### Step 1: Prepare Your Cover Images

You need to add **10 book cover images** to make the app work properly.

#### File Requirements:
- **Format:** JPG or PNG
- **Recommended Size:** 400x600px (or similar book cover ratio)
- **Location:** `assets/images/covers/`

#### Required Filenames (EXACT NAMES):

1. `around_the_world.jpg` - Around the World in Eighty Days
2. `monte_cristo.jpg` - The Count of Monte Cristo
3. `jekyll_hyde.jpg` - The Strange Case of Dr. Jekyll and Mr. Hyde
4. `dorian_gray.jpg` - The Picture of Dorian Gray
5. `call_of_wild.jpg` - The Call of the Wild
6. `treasure_island.jpg` - Treasure Island
7. `sherlock_holmes.jpg` - The Adventures of Sherlock Holmes
8. `dracula.jpg` - Dracula
9. `pride_prejudice.jpg` - Pride and Prejudice
10. `great_gatsby.jpg` - The Great Gatsby

⚠️ **IMPORTANT:** Filenames must match EXACTLY as shown above (case-sensitive, no spaces)

### Where to Get Book Covers:

**Free Options:**
1. **Google Images** - Search "book title cover" + "public domain" or "free"
2. **Open Library** - https://openlibrary.org/ (high-quality covers)
3. **Project Gutenberg** - https://www.gutenberg.org/ (some books have covers)
4. **Free Stock Photos** - Unsplash, Pexels, Pixabay

**Tips:**
- Look for vintage or classic edition covers (often public domain)
- You can use the same cover image multiple times if needed
- Resize images to ~400x600px to keep app size small

---

## 📖 Book Content (Text Files)

### Step 2: Get the Book Text

All 10 books are **public domain classics** and free to download!

#### Best Source: Project Gutenberg

1. Go to **https://www.gutenberg.org/**
2. Search for each book title
3. Download as **Plain Text UTF-8**
4. Save with the correct filename (see below)

#### Required Filenames (EXACT NAMES):

1. `around_the_world.txt` - Around the World in Eighty Days by Jules Verne
2. `monte_cristo.txt` - The Count of Monte Cristo by Alexandre Dumas
3. `jekyll_hyde.txt` - The Strange Case of Dr. Jekyll and Mr. Hyde by Robert Louis Stevenson
4. `dorian_gray.txt` - The Picture of Dorian Gray by Oscar Wilde
5. `call_of_wild.txt` - The Call of the Wild by Jack London
6. `treasure_island.txt` - Treasure Island by Robert Louis Stevenson
7. `sherlock_holmes.txt` - The Adventures of Sherlock Holmes by Arthur Conan Doyle
8. `dracula.txt` - Dracula by Bram Stoker
9. `pride_prejudice.txt` - Pride and Prejudice by Jane Austen
10. `great_gatsby.txt` - The Great Gatsby by F. Scott Fitzgerald

### Step 3: Convert EPUB to TXT (if needed)

If you have EPUB files instead of TXT:

#### Using Calibre (Recommended - FREE):

1. Download Calibre: https://calibre-ebook.com/
2. Install and open Calibre
3. Click **"Add books"** and select your EPUB file
4. Right-click the book and select **"Convert books"**
5. In **"Output format"**, select **TXT**
6. Click **OK** to convert
7. Right-click book again → **"Open containing folder"**
8. Find the TXT file and rename it to match the required filename
9. Move it to `assets/books/` folder

#### Using Online Converters:
- https://convertio.co/epub-txt/
- https://www.zamzar.com/convert/epub-to-txt/

### Step 4: Place Files in Correct Location

Place all `.txt` files in:
```
assets/books/
```

### What if I Don't Have All Books Yet?

The app will show **placeholder text** for any missing book. You can:
- Start with just 1-2 books
- Add more books later
- The app will still work, but will show "placeholder content" message

---

## 🎨 Optional: App Logo

### Logo Specifications:
- **Format:** PNG with transparent background
- **Size:** 200x200px
- **Location:** `assets/images/logo/logo.png`

If you don't add a logo, the app will show a default book emoji (📚).

---

## 📁 Final Folder Structure

After adding all assets, your folder should look like this:

```
boom_flutter_app/
├── assets/
│   ├── images/
│   │   ├── covers/
│   │   │   ├── around_the_world.jpg
│   │   │   ├── monte_cristo.jpg
│   │   │   ├── jekyll_hyde.jpg
│   │   │   ├── dorian_gray.jpg
│   │   │   ├── call_of_wild.jpg
│   │   │   ├── treasure_island.jpg
│   │   │   ├── sherlock_holmes.jpg
│   │   │   ├── dracula.jpg
│   │   │   ├── pride_prejudice.jpg
│   │   │   └── great_gatsby.jpg
│   │   └── logo/
│   │       └── logo.png (optional)
│   └── books/
│       ├── around_the_world.txt
│       ├── monte_cristo.txt
│       ├── jekyll_hyde.txt
│       ├── dorian_gray.txt
│       ├── call_of_wild.txt
│       ├── treasure_island.txt
│       ├── sherlock_holmes.txt
│       ├── dracula.txt
│       ├── pride_prejudice.txt
│       └── great_gatsby.txt
```

---

## ✅ Testing Your Assets

After adding assets:

1. Run `flutter pub get`
2. Run `flutter run`
3. Check that:
   - All book covers appear on Home and Library screens
   - You can open and read books
   - No "placeholder content" message appears

---

## 🆘 Troubleshooting

### "Image not found" error:
- Check filename spelling (case-sensitive!)
- Make sure file is in correct folder
- File extension should be `.jpg` or `.png`
- Try `flutter clean` then `flutter run`

### "Unable to load asset" error:
- Check `pubspec.yaml` has correct asset paths
- Run `flutter pub get` again
- Restart your IDE

### Book shows placeholder text:
- Text file is missing or incorrectly named
- Check file is in `assets/books/` folder
- Filename must match exactly

---

## 🎯 Quick Checklist

Before running the app, make sure you have:

- [ ] 10 book cover images in `assets/images/covers/`
- [ ] All filenames match EXACTLY as specified
- [ ] 10 book text files in `assets/books/`
- [ ] Text files are UTF-8 encoded
- [ ] Run `flutter pub get`
- [ ] Covers are readable size (not too small)

---

## 💡 Pro Tips

1. **Start Small:** Add 2-3 books first to test, then add the rest
2. **Compress Images:** Use tools like TinyPNG to reduce image sizes
3. **Clean Text:** Remove Project Gutenberg headers/footers from text files for cleaner reading
4. **Test Often:** Run the app after adding each book to catch issues early

---

**Need Help?**

If you're stuck, check:
- The error message in Flutter console
- The README.md file for more details
- Make sure all filenames match EXACTLY

Happy reading! 📚✨
