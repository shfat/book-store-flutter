import '../models/books.dart';

/// Represents a single item inside the shopping cart.
///
/// Stores the selected book and the number of copies requested.
class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });
}


/// Manages shopping cart data across the application.
///
/// Implemented as a Singleton to provide a single shared cart instance
/// accessible from different screens.
class Cart {

  // Private singleton instance.
  static final Cart _instance = Cart._internal();

  // Returns the existing cart instance instead of creating new objects.
  factory Cart() => _instance;

  // Private constructor for Singleton implementation.
  Cart._internal();


  // Internal list containing all selected cart items.
  final List<CartItem> _items = [];


  /// Adds a book to the cart.
  ///
  /// If the book already exists, only its quantity is increased.
  /// Otherwise, a new cart item is created.
  void addItem(Book book, {int quantity = 1}) {

    for (var item in _items) {

      if (item.book.title == book.title) {
        item.quantity += quantity;
        return;
      }
    }

    _items.add(
      CartItem(
        book: book,
        quantity: quantity,
      ),
    );
  }


  /// Removes a book completely from the cart.
  void removeItem(Book book) {

    _items.removeWhere(
          (item) => item.book.title == book.title,
    );
  }


  /// Decreases the quantity of a selected book.
  ///
  /// Removes the item completely if its quantity reaches zero.
  void decreaseQuantity(Book book) {

    for (var item in _items) {

      if (item.book.title == book.title) {

        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _items.remove(item);
        }

        return;
      }
    }
  }


  /// Returns all current cart items.
  List<CartItem> get items => _items;


  /// Calculates and returns the formatted total price of the cart.
  String get totalPrice {

    int total = 0;


    for (var item in _items) {

      // Converts formatted price text into an integer value.
      String priceString = item.book.price
          .replaceAll(',', '')
          .replaceAll('تومان', '')
          .replaceAll(' ', '')
          .trim();


      if (priceString.isNotEmpty) {

        int price = int.parse(priceString);

        total += price * item.quantity;
      }
    }


    if (total == 0) {
      return '0 تومان';
    }


    // Adds thousands separators for better readability.
    return '${total.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    )} تومان';
  }


  /// Returns the total number of books including quantities.
  int get totalItems {

    int count = 0;

    for (var item in _items) {
      count += item.quantity;
    }

    return count;
  }


  /// Returns the number of unique books in the cart.
  int get itemCount => _items.length;


  /// Removes all items from the cart.
  void clear() {
    _items.clear();
  }


  /// Checks whether a specific book exists in the cart.
  bool isInCart(Book book) {

    for (var item in _items) {

      if (item.book.title == book.title) {
        return true;
      }
    }

    return false;
  }


  /// Returns the selected quantity of a specific book.
  ///
  /// Returns zero if the book is not available in the cart.
  int getQuantity(Book book) {

    for (var item in _items) {

      if (item.book.title == book.title) {
        return item.quantity;
      }
    }

    return 0;
  }
}