# NovelGlide

A first attempt to develop a cross-platform app.

## Development Environment

- Flutter version: 3.22.3

## Features

- **Reading features**
    - Read a novel chapter (in text format).
    - Save a bookmark and jump to it.
- **Appearance features**
    - Change the font size and line height.
    - Change the theme and brightness.
- **Backup features**
    - Backup your library to Google Drive.
    - Restore your library from Google Drive.
- **Import features**
    - Import chapters to a book from a zip file.
        - You can determine whether to overwrite the existing chapter, cover, or bookmark.
        - The structure of the zip file should be like this:
          ```
          BookName.zip (The name of the zip file is not important.)
          ├── Chapter.1.txt         // Treat it as Chapter 1.
          ├── Chapter.2.txt         // Treat it as Chapter 2.
          ├── Chapter.3.txt
          ├── Cover.jpg             // Treat it as the cover of the book.
          ├── bookmark.isar         // Treat it as the bookmark of the book.
          ├── bookmark.isar.lock    // Treat it as the bookmark of the book.
          └── The other files...    // Ignored.
          ```
    - Import books from a zip file.
        - The chapters, cover image, and bookmark in the book folder will be imported.
        - The structure of the zip file should be like this:
          ```
          Bookshelf.zip (The name of the zip file is not important.)
          ├── BookName1         // Treat it as a book named BookName1.
          ├── BookName2         // Treat it as a book named BookName2.
          ├── BookName3         // Treat it as a book named BookName3.
          └── The other files...    // Ignored.
          ```
- **Tablet Support**
    - Change the layout to a larger screen such as a tablet.

## Guide

- [The Guide of the Book Operation](https://blog.kai-wu.net/2024/07/novelglide-book-guide.html) (Traditional Chinese)

## Download Links

- [Google Play Store](https://play.google.com/store/apps/details?id=com.kai_wu.novelglide) (still in closed beta
  testing)

## TODO-List

- [ ] Export books
