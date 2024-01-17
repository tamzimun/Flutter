class Library {
  Map<int, Map<String, String>> books = {};
  List<String> readers = [];

  Set<int> issuedBooks = {};

  void addBook(int id, String title, String author) {
    books[id] = {'title': title, 'author': author};
  }

  void removeBook(int id) {
    books.remove(id);
    issuedBooks.remove(id);
  }

  void registerReader(String name) {
    readers.add(name);
  }

  void removeReader(String name) {
    readers.remove(name);
  }

  void lendBook(int bookId) {
    if (books.containsKey(bookId)) {
      issuedBooks.add(bookId);
    } else {
      print('Книга с ID $bookId не найдена в библиотеке.');
    }
  }

  void returnBook(int bookId) {
    issuedBooks.remove(bookId);
  }

  List<int> searchBook(String query) {
    List<int> result = [];
    books.forEach((id, bookInfo) {
      if (bookInfo.containsValue(query)) {
        result.add(id);
      }
    });
    return result;
  }

  // Фильтрация списка читателей по критериям (например, дата регистрации)
  List<String> filterReaders(bool Function(String) filterFunction) {
    return readers.where(filterFunction).toList();
  }
}