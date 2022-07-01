import 'package:flutter/cupertino.dart';
import 'package:sqlite_demo/extension.dart';

import 'model/book_route_path.dart';
import 'nested_screen.dart';

class BooksAppState extends ChangeNotifier {
  int _selectedIndex = 0;

  Book? _selectedBook;

  BooksAppState();

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    notifyListeners();
  }

  Book? get selectedBook => _selectedBook;

  set selectedBook(Book? book) {
    _selectedBook = book;
    notifyListeners();
  }

  int getSelectedBookById() {
    if (!books.contains(_selectedBook)) return 0;
    return books.indexOf(_selectedBook ?? books[0]);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > books.length - 1) {
      return;
    }

    _selectedBook = books[id];
    notifyListeners();
  }

  Future<bool> backPress() async {
    if (selectedIndex == 0) {
      if (selectedBook != null) {
        selectedBook = null;
        notifyListeners();
        return true;
      } else if (selectedBook == null) {
        notify("back");
        return false;
      }
    } else {
      selectedIndex = 0;
      return true;
    }
    notifyListeners();
    return true;
  }
}
