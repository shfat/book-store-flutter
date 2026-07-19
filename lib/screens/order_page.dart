// Import core Flutter material components and custom services/utilities.
import 'package:flutter/material.dart';
import '../../services/cart.dart';
import '../../utilities/constants.dart';

/// OrderPage - displays the shopping cart and a checkout form.
/// Allows users to review cart items, adjust quantities, remove items,
/// and submit an order with personal details.
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Form key for validation of user input fields.
  final _formKey = GlobalKey<FormState>();

  // Instance of the cart service to manage items and totals.
  final Cart _cart = Cart();

  // Controllers for user input fields.
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks.
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Validates the form, checks if cart is empty, and submits the order.
  /// Displays appropriate feedback via SnackBar and clears the cart on success.
  void _submitOrder() {
    // Validate all form fields.
    if (_formKey.currentState!.validate()) {
      // Guard against empty cart.
      if (_cart.items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'سبد خرید شما خالی است!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: kErrorColor,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusMedium),
            ),
          ),
        );
        return;
      }

      // Success snackbar with order summary.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'سفارش شما با موفقیت ثبت شد!',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                '📚 ${_cart.totalItems} کتاب',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              Text(
                '💰 ${_cart.totalPrice}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          backgroundColor: kPrimaryColor,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusMedium),
          ),
        ),
      );

      // Clear cart, reset form fields and controllers.
      _cart.clear();
      _formKey.currentState!.reset();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _addressController.clear();

      // Navigate back after a short delay to give user time to see success.
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSurfaceColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          'سبد خرید',
          style: kTitleSmallTextStyle,
        ),
        centerTitle: true,
        // Action button showing cart icon with item count badge.
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: kPrimaryColor),
                onPressed: () {
                  // Refresh UI when cart icon is tapped.
                  setState(() {});
                },
              ),
              // Badge displaying total item count if > 0.
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
      body: Padding(
        padding: const EdgeInsets.all(kPaddingXLarge),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ---- Cart Items Section ----
              // Display a card with all cart items if not empty.
              if (_cart.items.isNotEmpty)
                Card(
                  color: kSurfaceColor,
                  elevation: 4,
                  shadowColor: kPrimaryColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusMedium),
                    side: BorderSide(
                      color: kPrimaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kPaddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header.
                        const Row(
                          children: [
                            Icon(Icons.shopping_cart, color: kPrimaryColor, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'کتاب های سبد خرید',
                              style: kOrderTitleTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Map each cart item to a row with controls.
                        ..._cart.items.map((item) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(kPaddingSmall),
                          decoration: BoxDecoration(
                            color: kSurfaceLightColor,
                            borderRadius: BorderRadius.circular(kRadiusSmall),
                          ),
                          child: Row(
                            children: [
                              // Book title and author.
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.book.title,
                                      style: kCardTitleTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.book.author,
                                      style: kAuthorTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              // Price.
                              Expanded(
                                child: Text(
                                  item.book.price,
                                  style: kPriceTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Quantity controls and remove button.
                              Row(
                                children: [
                                  // Decrease quantity.
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cart.decreaseQuantity(item.book);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: kSurfaceColor,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: kPrimaryColor.withOpacity(0.3),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: kPrimaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Increase quantity.
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cart.addItem(item.book, quantity: 1);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: kSurfaceColor,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: kPrimaryColor.withOpacity(0.3),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: kPrimaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Remove item completely.
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cart.removeItem(item.book);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: kErrorColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: kErrorColor.withOpacity(0.3),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: kErrorColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                        // Total price row.
                        const Divider(color: kBorderColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'جمع کل:',
                              style: kOrderTitleTextStyle,
                            ),
                            Text(
                              _cart.totalPrice,
                              style: kOrderTotalTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              // ---- Empty Cart State ----
              if (_cart.items.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: kSurfaceColor,
                    borderRadius: BorderRadius.circular(kRadiusMedium),
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'سبد خرید خالی است!',
                        style: kTitleSmallTextStyle,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'برای خرید، کتاب مورد نظر را انتخاب کنید',
                        style: TextStyle(
                          color: kTextSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: kPrimaryButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('برو به فروشگاه'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              // ---- Checkout Form (only shown when cart has items) ----
              if (_cart.items.isNotEmpty) ...[
                // First name field.
                TextFormField(
                  controller: _firstNameController,
                  style: const TextStyle(color: kTextColor),
                  decoration: InputDecoration(
                    labelText: 'نام',
                    labelStyle: const TextStyle(color: kTextSecondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: kSurfaceColor,
                    prefixIcon: const Icon(Icons.person_outline, color: kPrimaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفا نام خود را وارد کنید';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                // Last name field.
                TextFormField(
                  controller: _lastNameController,
                  style: const TextStyle(color: kTextColor),
                  decoration: InputDecoration(
                    labelText: 'نام خانوادگی',
                    labelStyle: const TextStyle(color: kTextSecondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: kSurfaceColor,
                    prefixIcon: const Icon(Icons.person_outline, color: kPrimaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفا نام خانوادگی خود را وارد کنید';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                // Phone number field with numeric keyboard and validation.
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: kTextColor),
                  decoration: InputDecoration(
                    labelText: 'شماره تماس',
                    labelStyle: const TextStyle(color: kTextSecondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: kSurfaceColor,
                    prefixIcon: const Icon(Icons.phone_outlined, color: kPrimaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفا شماره تماس خود را وارد کنید';
                    }
                    final digitsOnly = RegExp(r'^[0-9]{10,11}$');
                    if (!digitsOnly.hasMatch(value.trim())) {
                      return 'شماره تماس معتبر نیست (فقط عدد، ۱۰ تا ۱۱ رقم)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                // Address field (multi-line).
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  style: const TextStyle(color: kTextColor),
                  decoration: InputDecoration(
                    labelText: 'آدرس',
                    labelStyle: const TextStyle(color: kTextSecondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: kSurfaceColor,
                    prefixIcon: const Icon(Icons.location_on_outlined, color: kPrimaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفا آدرس خود را وارد کنید';
                    }
                    if (value.trim().length < 10) {
                      return 'آدرس را کاملتر وارد کنید';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Submit button with gradient styling and total item count.
                SizedBox(
                  height: kButtonHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                    ),
                    child: ElevatedButton(
                      style: kGradientButtonStyle,
                      onPressed: _submitOrder,
                      child: Text(
                        'ثبت سفارش (${_cart.totalItems} کتاب)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}