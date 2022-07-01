// Routes
abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BooksDetailsPath extends BookRoutePath {
  final int id;

  BooksDetailsPath(this.id);
}


class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}


final List<Book> books = [
  Book('Cô giáo thảo', 'Vô danh'),
  Book('300 bài code thiếu nhi', 'Fukuda'),
  Book('Nghệ thuật móc túi', 'harry porter'),
];
