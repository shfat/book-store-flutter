import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../services/cart.dart';
import '../../utilities/constants.dart';

/// Displays detailed information about a selected book.
///
/// Allows users to view book details, select quantity,
/// and add the selected item to the shopping cart.
class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {

  // Shared cart service used to update shopping cart data.
  final Cart _cart = Cart();

  // Number of selected copies of the current book.
  int _quantity = 1;


  /// Adds the selected book with the chosen quantity to the cart.
  ///
  /// Displays a confirmation message and returns the user
  /// to the previous screen after completing the action.
  void _addToCart() {
    _cart.addItem(widget.book, quantity: _quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.book.title} (x$_quantity) به سبد خرید اضافه شد',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusMedium),
        ),
      ),
    );

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // Displays book title and current cart status.
      appBar: AppBar(
        backgroundColor: kSurfaceColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: Text(
          widget.book.title,
          style: kTitleSmallTextStyle,
        ),
        centerTitle: true,

        actions: [

          // Cart shortcut with current item count indicator.
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              if (_cart.totalItems > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: kErrorColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${_cart.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Displays book cover image with fallback placeholder.
            SizedBox(
              height: 320,
              child: Image.asset(
                widget.book.coverAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: kSurfaceLightColor,
                  child: const Icon(
                    Icons.book,
                    size: 96,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(kPaddingXLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Book information section.
                  Text(
                    widget.book.title,
                    style: kBookTitleTextStyle,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'نویسنده: ${widget.book.author}',
                    style: kBookAuthorTextStyle,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    widget.book.description,
                    style: kBookDescriptionTextStyle,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.book.price,
                    style: kBookPriceTextStyle,
                  ),

                  const SizedBox(height: 20),

                  // Quantity selector component.
                  Container(
                    padding: const EdgeInsets.all(kPaddingLarge),
                    decoration: BoxDecoration(
                      color: kSurfaceColor,
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      border: Border.all(
                        color: kPrimaryColor.withOpacity(0.3),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'تعداد:',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [

                            // Decreases selected quantity with minimum value of 1.
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_quantity > 1) _quantity--;
                                });
                              },

                              child: Container(
                                padding: const EdgeInsets.all(kPaddingSmall),
                                decoration: BoxDecoration(
                                  color: kSurfaceLightColor,
                                  borderRadius: BorderRadius.circular(
                                    kRadiusSmall,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            Text(
                              '$_quantity',
                              style: const TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Increases selected quantity.
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _quantity++;
                                });
                              },

                              child: Container(
                                padding: const EdgeInsets.all(kPaddingSmall),
                                decoration: BoxDecoration(
                                  color: kSurfaceLightColor,
                                  borderRadius: BorderRadius.circular(
                                    kRadiusSmall,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Primary action button for adding item to cart.
                  SizedBox(
                    width: double.infinity,
                    height: kButtonHeight,

                    child: Container(
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                      ),

                      child: ElevatedButton.icon(
                        style: kGradientButtonStyle,

                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),

                        label: Text(
                          'افزودن به سبد خرید (x$_quantity)',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        onPressed: _addToCart,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}