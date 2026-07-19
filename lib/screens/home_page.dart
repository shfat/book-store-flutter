import 'package:bookstore_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../services/cart.dart';
import 'book_detail_page.dart';
import 'about_page.dart';
import 'order_page.dart';
import 'welcome_page.dart';

/// Main bookstore screen displaying available books.
///
/// Provides access to the book catalog, shopping cart,
/// application navigation drawer, and user actions.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Shared cart instance used to manage selected books.
  final Cart cart = Cart();

  /// Refreshes the UI after cart data changes.
  ///
  /// Since the cart is managed outside this widget,
  /// rebuilding the widget updates displayed cart information.
  void _refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // Application header containing title and cart shortcut.
      appBar: AppBar(
        backgroundColor: kSurfaceColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          'کتابکده',
          style: kTitleTextStyle,
        ),
        centerTitle: true,

        actions: [
          // Displays current cart item count as a notification badge.
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: kPrimaryColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderPage()),
                  ).then((_) {
                    _refreshPage();
                  });
                },
              ),

              if (cart.totalItems > 0)
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
                      '${cart.totalItems}',
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

      // Side navigation drawer containing application sections.
      drawer: Drawer(
        backgroundColor: kSurfaceColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            // User profile header with branded gradient background.
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: kDrawerGradient,
              ),
              accountName: Text(
                'کتابکده',
                style: kDrawerHeaderTextStyle,
              ),
              accountEmail: Text(
                'فروشگاه آنلاین کتاب',
                style: kDrawerEmailTextStyle,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: kTextColor,
                child: Icon(Icons.menu_book, size: 36, color: kPrimaryColor),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home_outlined, color: kPrimaryColor),
              title: const Text(
                'صفحه اصلی',
                style: kDrawerTextStyle,
              ),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined, color: kPrimaryColor),
              title: const Text(
                'سبد خرید',
                style: kDrawerTextStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderPage()),
                ).then((_) {
                  _refreshPage();
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.info_outline, color: kPrimaryColor),
              title: const Text(
                'درباره ما',
                style: kDrawerTextStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),

            const Divider(
              color: kBorderColor,
              thickness: 1,
            ),

            // Logout action with confirmation dialog.
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: kErrorColor),
              title: const Text(
                'خروج',
                style: TextStyle(color: kErrorColor),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: kSurfaceColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusLarge),
                      side: BorderSide(
                        color: kPrimaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    title: const Text(
                      'خروج از حساب',
                      style: kDialogTitleTextStyle,
                    ),
                    content: const Text(
                      'آیا مطمئن هستید؟',
                      style: kDialogContentTextStyle,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'انصراف',
                          style: kDialogButtonTextStyle,
                        ),
                      ),

                      ElevatedButton(
                        style: kErrorButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);

                          // Clears user cart data before leaving the application.
                          cart.clear();

                          _refreshPage();

                          // Returns user to authentication screen.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WelcomePage(),
                            ),
                          );
                        },
                        child: const Text('خروج'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Responsive grid displaying available books.
      body: GridView.builder(
        padding: const EdgeInsets.all(kPaddingMedium),
        itemCount: sampleBooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: kPaddingMedium,
          mainAxisSpacing: kPaddingMedium,
        ),
        itemBuilder: (context, index) {
          final book = sampleBooks[index];

          return _BookCard(
            book: book,
            onCartChanged: _refreshPage,
          );
        },
      ),
    );
  }
}


/// Reusable card widget used to display individual book information.
///
/// Shows cover image, title, author, price, and current cart quantity.
class _BookCard extends StatelessWidget {

  final Book book;
  final VoidCallback onCartChanged;

  const _BookCard({
    required this.book,
    required this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {

    // Accesses shared cart state to display selected quantities.
    final Cart cart = Cart();

    return InkWell(
      borderRadius: BorderRadius.circular(kRadiusMedium),

      // Opens detailed information page for the selected book.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailPage(book: book),
          ),
        ).then((_) {
          onCartChanged();
        });
      },

      child: Card(
        color: kSurfaceColor,
        elevation: 4,
        shadowColor: kPrimaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusMedium),
          side: BorderSide(
            color: kBorderColor.withOpacity(0.5),
            width: 1,
          ),
        ),

        clipBehavior: Clip.antiAlias,

        child: Stack(
          children: [

            // Book cover and basic information section.
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    book.coverAsset,
                    fit: BoxFit.cover,

                    // Provides fallback UI when image loading fails.
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: kSurfaceLightColor,
                      child: const Icon(
                        Icons.book,
                        size: 48,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingSmall,
                    vertical: kPaddingSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kAuthorTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.price,
                        style: kPriceTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Shows selected quantity badge when the book exists in the cart.
            if (cart.isInCart(book))
              Positioned(
                top: kPaddingSmall,
                right: kPaddingSmall,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kRadiusSmall),
                  ),
                  child: Text(
                    'x${cart.getQuantity(book)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}